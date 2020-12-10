import UIKit

class HabitCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "HabitCell"
    
    private let iconContainer = UIView()
    private let iconImageView = LSImageView()
    private let habitNameLabel = LSTitleLabel(textColor: UIColor.appColor(color: .darkestAsh), fontSize: 15)
    private let habitDaysLabel = LSBodyLabel(textColor: UIColor.appColor(color: .darkestAsh), fontSize: 16)
    
    private var shapeRing: CAShapeLayer?
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Public Methods
extension HabitCell {
    
    func setup(habit: Habit) {
//        iconImageView.image = UIImage(named: habit.icon)
        iconImageView.image = iconImageView.image?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.appColor(color: .lightBlack)
        habitDaysLabel.text = "\(habit.days) \(Strings.days)"
        habitNameLabel.text = (habit.name ?? "").uppercased()
        setupShapeRing(days: Int(habit.days))
    }
}


// MARK: - Methods
private extension HabitCell {

    func setupShapeRing(days: Int) {
        let strokeEndValue = CGFloat(Double(days) / Double(GlobalConstants.lifeStyleDays))
        let radius = frame.width / 2 - 30
        if let shapeRing = shapeRing {
            shapeRing.removeFromSuperlayer()
        }
        shapeRing = addRing(radius: radius, strokeColor: UIColor.appColor(color: .lightBlack), fillColor: .clear, strokeEnd: strokeEndValue)
        layer.addSublayer(shapeRing!)
        shapeRing!.strokeEndAnimation(fromValue: 0, toValue: strokeEndValue, duration: 0.5)
    }
    
    
    func setupViews() {
        contentView.addSubviews(iconContainer, iconImageView, habitDaysLabel, habitNameLabel)

        let width = frame.width
        let iconDimensions = width / 2 - 50
        iconContainer.backgroundColor = .clear
        iconContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: frame.width - 40))
        iconImageView.center(in: iconContainer, size: .init(width: iconDimensions, height: iconDimensions))
        habitDaysLabel.anchor(top: iconImageView.bottomAnchor, leading: iconContainer.leadingAnchor, bottom: nil, trailing: iconContainer.trailingAnchor, padding: .init(top: 4, left: 4, bottom: 0, right: 4))
        habitNameLabel.anchor(top: iconContainer.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 4, bottom: 0, right: 4))
        
        let radius = width / 2 - 30
        let trackRing = addRing(radius: radius, strokeColor:  UIColor.appColor(color: .lighestGreen), fillColor: .clear)
        layer.addSublayer(trackRing)
    }
}
