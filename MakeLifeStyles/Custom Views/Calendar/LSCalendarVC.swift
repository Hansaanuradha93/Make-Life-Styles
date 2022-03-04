import UIKit

class LSCalendarVC: UIViewController {
    
    // Types
    enum CalendarDataError: Error {
        case metadataGeneration
    }
    
    
    // MARK: UI Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var headerView = CalendarPickerHeaderView { [weak self] in
        guard let self = self else { return }
        
        self.dismiss(animated: true)
    }

    private lazy var footerView = CalendarPickerFooterView(didTapLastMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }

            self.baseDate = self.calendar.date(byAdding: .month, value: -1, to: self.baseDate) ?? self.baseDate
        }, didTapNextMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }

            self.baseDate = self.calendar.date(byAdding: .month, value: 1, to: self.baseDate) ?? self.baseDate
        }
    )
    
    
    // MARK: Calendar Date Properties
    private let selectedDate: Date
    
    private lazy var days = generateDaysInMonth(for: baseDate)

    private var numberOfWeeksInBaseDate: Int {
      calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
    
    private var baseDate: Date {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            collectionView.reloadData()
            headerView.baseDate = baseDate
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
        
    private let selectedDateChanged: ((Date) -> Void)
    private let calendar = Calendar(identifier: .gregorian)

    
    // MARK: Initializers
    init(baseDate: Date, selectedDateChanged: @escaping ((Date) -> Void)) {
        self.selectedDate = baseDate
        self.baseDate = baseDate
        self.selectedDateChanged = selectedDateChanged
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension LSCalendarVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = days[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDateCell.reuseID, for: indexPath) as! CalendarDateCell
        
        cell.day = day
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension LSCalendarVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        selectedDateChanged(day.date)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
        return CGSize(width: width, height: height)
    }
}


// MARK: - Private Methods
private extension LSCalendarVC {
    
    func style() {
        collectionView.backgroundColor = .systemGroupedBackground
        
        collectionView.register(CalendarDateCell.self, forCellWithReuseIdentifier: CalendarDateCell.reuseID)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        headerView.baseDate = baseDate
    }
    
    
    func layout() {
        view.addSubviews(collectionView, headerView, footerView)
        
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 85))
        
        footerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 85))
        
        collectionView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: footerView.topAnchor, trailing: view.trailingAnchor)
    }
}


// MARK: - Day Generation
private extension LSCalendarVC {
    
    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        
        guard let numberOfDaysInMonth = calendar.range(
            of: .day,
            in: .month,
            for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate)) else {
                    throw CalendarDataError.metadataGeneration
                }
        
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        return MonthMetadata(numberOfDays: numberOfDaysInMonth, firstDay: firstDayOfMonth, firstDayWeekday: firstDayWeekday)
    }
    
    
    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let metadata = try? monthMetadata(for: baseDate) else {
            fatalError("An error occurred when generating the metadata for \(baseDate)")
        }
        
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow)).map { day in
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                
                let dayOffset = isWithinDisplayedMonth ? day - offsetInInitialRow : -(offsetInInitialRow - day)
                
                return generateDay(offsetBy: dayOffset, for: firstDayOfMonth, isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
        
        days += generateStartOfNextMonth(using: firstDayOfMonth)
        
        return days
    }
    
    
    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
        let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        
        return Day(date: date, number: dateFormatter.string(from: date), isSelected: calendar.isDate(date, inSameDayAs: selectedDate), isWithinDisplayedMonth: isWithinDisplayedMonth)
    }
    
    
    func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
        guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfDisplayedMonth) else { return [] }
        
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        
        guard additionalDays > 0 else { return [] }
        
        let days: [Day] = (1...additionalDays).map {
                generateDay(offsetBy: $0, for: lastDayInMonth, isWithinDisplayedMonth: false)
            }
        
        return days
    }


}

