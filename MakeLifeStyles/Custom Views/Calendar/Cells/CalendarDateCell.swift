import UIKit

class CalendarDateCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = String(describing: CalendarDateCell.self)
    
    private lazy var selectionBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = AppColor.pinkishRed
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = LSBodyLabel(textColor: AppColor.lightBlack, fontSize: 16, textAlignment: .center)
        return label
    }()
    
    private lazy var accessibilityDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        return dateFormatter
    }()
    
    
    private var isSmallScreenSize: Bool {
        let isCompact = traitCollection.horizontalSizeClass == .compact
        let smallWidth = UIScreen.main.bounds.width <= 350
        let widthGreaterThanHeight =
        UIScreen.main.bounds.width > UIScreen.main.bounds.height
        
        return isCompact && (smallWidth || widthGreaterThanHeight)
    }
    
    var day: Day? {
        didSet {
            guard let day = day else { return }
            
            numberLabel.text = day.number
            accessibilityLabel = accessibilityDateFormatter.string(from: day.date)
            
            updateSelectionStatus()
        }
    }

    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - Private Methods
private extension CalendarDateCell {
    
    func setup() {
        isAccessibilityElement = true
        accessibilityTraits = .button
        
        contentView.addSubviews(selectionBackgroundView, numberLabel)
        
        NSLayoutConstraint.deactivate(selectionBackgroundView.constraints)

        let size = traitCollection.horizontalSizeClass == .compact ? min(min(frame.width, frame.height) - 10, 40) : 25
        
        numberLabel.center(in: contentView)
        
        selectionBackgroundView.center(in: numberLabel, size: .init(width: size, height: size))

        selectionBackgroundView.layer.cornerRadius = size / 2
    }
    
    
    func updateSelectionStatus() {
        guard let day = day else { return }
        
        if day.isSelected {
            applySelectedStyle()
        } else {
            applyDefaultStyle(isWithinDisplayedMonth: day.isWithinDisplayedMonth)
        }
    }
    

    func applySelectedStyle() {
        accessibilityTraits.insert(.selected)
        accessibilityHint = nil
        
        numberLabel.textColor = isSmallScreenSize ? AppColor.pinkishRed : .white
        selectionBackgroundView.isHidden = isSmallScreenSize
    }
    

    func applyDefaultStyle(isWithinDisplayedMonth: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = "Tap to select"
        
        numberLabel.textColor = isWithinDisplayedMonth ? AppColor.lightBlack : AppColor.lightAsh
        selectionBackgroundView.isHidden = true
    }
}

