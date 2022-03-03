import UIKit

class CalendarPickerHeaderView: UIView {
    
    // TODO: finalize colors

    // MARK: Properties
    lazy var monthLabel: UILabel = {
        let label = LSTitleLabel(text: "Month", textColor: AppColor.lightBlack, fontSize: 26, textAlignment: .left)
        label.accessibilityTraits = .header
        label.isAccessibilityElement = true
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = LSButton()
        
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = Asserts.xmarkCircleFill
        image.withConfiguration(configuration)
        button.setImage(image, for: .normal)
        
        button.tintColor = AppColor.lightBlack
        button.contentMode = .scaleAspectFill
        button.isUserInteractionEnabled = true
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Close Picker"
        return button
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
        view.backgroundColor = AppColor.lightBlack.withAlphaComponent(0.2)
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
    
    var exitButtonTappedCompletionHandler: (() -> Void)
    
    
    // MARK: Initializers
    init(exitButtonTappedCompletionHandler: @escaping (() -> Void)) {
        self.exitButtonTappedCompletionHandler = exitButtonTappedCompletionHandler
        
        super.init(frame: CGRect.zero)
                
        backgroundColor = .systemGroupedBackground
        
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        layer.cornerCurve = .continuous
        layer.cornerRadius = 15
        
        addSubviews(monthLabel, closeButton, dayOfWeekStackView, separatorView)
        
        for dayNumber in 1...7 {
            let dayLabel = UILabel()
            dayLabel.font = .systemFont(ofSize: 12, weight: .bold)
            dayLabel.textColor = .secondaryLabel
            dayLabel.textAlignment = .center
            dayLabel.text = dayOfWeekLetter(for: dayNumber)
            dayLabel.isAccessibilityElement = false
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
        
        closeButton.addTarget(self, action: #selector(didTapExitButton), for: .touchUpInside)
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
    
    @objc private func didTapExitButton() {
        exitButtonTappedCompletionHandler()
    }
    
    
    func layout() {
        monthLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: closeButton.leadingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 5))
        
        closeButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 28, height: 28))
        closeButton.centerVertically(in: monthLabel)
        
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
