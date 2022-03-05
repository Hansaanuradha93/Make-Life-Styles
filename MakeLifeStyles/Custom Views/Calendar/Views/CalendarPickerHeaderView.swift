import UIKit

class CalendarPickerHeaderView: UIView {
    
    // TODO: finalize colors

    // MARK: Properties
    lazy var monthLabel: UILabel = {
        let label = LSTitleLabel(text: "Month", textColor: AppColor.lightBlack, fontSize: 20, textAlignment: .left)
        label.accessibilityTraits = .header
        label.isAccessibilityElement = true
        return label
    }()
    
    lazy var dayOfWeekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.lightAsh.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
        return dateFormatter
    }()
    
    var baseDate = Date() {
        didSet {
            monthLabel.text = dateFormatter.string(from: baseDate)
        }
    }
    
    
    // MARK: Initializers
    init() {
        super.init(frame: CGRect.zero)
        initialSetup()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}


// MARK: - Private Methods
private extension CalendarPickerHeaderView {
    
    func initialSetup() {
        backgroundColor = .systemBackground
        
        addSubviews(monthLabel, dayOfWeekStackView, separatorView)
        
        for dayNumber in 1...7 {
            let dayLabel = LSTitleLabel(textColor: AppColor.darkestAsh, fontSize: 12, textAlignment: .center)
            dayLabel.text = dayOfWeekLetter(for: dayNumber)
            dayLabel.isAccessibilityElement = false
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
        
    }
    
    
    func layout() {
        monthLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: 20))
        
        separatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 1))
        
        dayOfWeekStackView.anchor(top: nil, leading: leadingAnchor, bottom: separatorView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
    }
    
    
    func dayOfWeekLetter(for dayNumber: Int) -> String {
        switch dayNumber {
        case 1:
            return "S"
        case 2:
            return "M"
        case 3:
            return "T"
        case 4:
            return "W"
        case 5:
            return "T"
        case 6:
            return "F"
        case 7:
            return "S"
        default:
            return ""
        }
    }
}
