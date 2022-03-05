import UIKit

class CalendarPickerHeaderView: UIView {
    
    // MARK: Properties
    private lazy var monthLabel: UILabel = {
        let label = LSTitleLabel(text: "Month", textColor: AppColor.lightBlack, fontSize: 20, textAlignment: .left)
        label.accessibilityTraits = .header
        label.isAccessibilityElement = true
        return label
    }()
    
    private lazy var dayOfWeekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.lightAsh.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var previousMonthButton: LSImageButton = {
        let buttonView = LSImageButton(image: Asserts.chevronLeftCircleFill, tintColor: AppColor.lightAsh.withAlphaComponent(0.5))
        
        buttonView.button.addTarget(self, action: #selector(didTapPreviousMonthButton), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var nextMonthButton: LSImageButton = {
        let buttonView = LSImageButton(image: Asserts.chevronRighttCircleFill, tintColor: AppColor.lightAsh.withAlphaComponent(0.5))
                
        buttonView.button.addTarget(self, action: #selector(didTapNextMonthButton), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousMonthButton, nextMonthButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
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
    
    private let didTapLastMonthCompletionHandler: (() -> Void)
    private let didTapNextMonthCompletionHandler: (() -> Void)
    
    
    // MARK: Initializers
    init(didTapLastMonthCompletionHandler: @escaping (() -> Void), didTapNextMonthCompletionHandler: @escaping (() -> Void)) {
        self.didTapLastMonthCompletionHandler = didTapLastMonthCompletionHandler
        self.didTapNextMonthCompletionHandler = didTapNextMonthCompletionHandler
        
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
    
    @objc func didTapPreviousMonthButton() {
        didTapLastMonthCompletionHandler()
    }
    
    
    @objc func didTapNextMonthButton() {
        didTapNextMonthCompletionHandler()
    }
    
    
    func initialSetup() {
        backgroundColor = .systemBackground
        
        addSubviews(buttonStackView, monthLabel, dayOfWeekStackView, separatorView)
        
        for dayNumber in 1...7 {
            let dayLabel = LSTitleLabel(textColor: AppColor.darkestAsh, fontSize: 12, textAlignment: .center)
            dayLabel.text = dayOfWeekLetter(for: dayNumber)
            dayLabel.isAccessibilityElement = false
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
        
    }
    
    
    func layout() {
        let buttonDimension: CGFloat = 35
        let buttonStackViewWidth: CGFloat = 2 * buttonDimension + 20
        
        buttonStackView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20), size: .init(width: buttonStackViewWidth, height: buttonDimension + 5))
        
        monthLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: buttonStackView.leadingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        monthLabel.centerVertically(in: buttonStackView)
        
        separatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 1))
        
        dayOfWeekStackView.anchor(top: nil, leading: leadingAnchor, bottom: separatorView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 5, right: 10))
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
