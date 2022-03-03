import UIKit

class CalendarDateCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = String(describing: CalendarDateCell.self)
    
    private lazy var selectionBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemRed
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = LSBodyLabel(textColor: AppColor.lightBlack, fontSize: 18, textAlignment: .center)
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
        
        contentView.addSubview(selectionBackgroundView)
        contentView.addSubview(numberLabel)
        
        NSLayoutConstraint.deactivate(selectionBackgroundView.constraints)

        let size = traitCollection.horizontalSizeClass == .compact ? min(min(frame.width, frame.height) - 10, 60) : 45
        
        numberLabel.center(in: contentView)
        
        selectionBackgroundView.center(in: numberLabel, size: .init(width: size, height: size))
        
//        NSLayoutConstraint.activate([
////          numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
////          numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//
//          selectionBackgroundView.centerYAnchor
//            .constraint(equalTo: numberLabel.centerYAnchor),
//          selectionBackgroundView.centerXAnchor
//            .constraint(equalTo: numberLabel.centerXAnchor),
//          selectionBackgroundView.widthAnchor.constraint(equalToConstant: size),
//          selectionBackgroundView.heightAnchor
//            .constraint(equalTo: selectionBackgroundView.widthAnchor)
//        ])

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
        
        numberLabel.textColor = isSmallScreenSize ? .systemRed : .white
        selectionBackgroundView.isHidden = isSmallScreenSize
    }
    

    func applyDefaultStyle(isWithinDisplayedMonth: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = "Tap to select"
        
        numberLabel.textColor = isWithinDisplayedMonth ? .label : .secondaryLabel
        selectionBackgroundView.isHidden = true
    }
}

