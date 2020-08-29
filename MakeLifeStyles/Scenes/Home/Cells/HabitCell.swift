import UIKit

class HabitCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "HabitCell"
    
    fileprivate let iconContainer = UIView()
    fileprivate let iconImageView = LSImageView()
    fileprivate let habitNameLabel = LSBodyLabel(textColor: .white, fontSize: 16)
    
    var shapeRing = CAShapeLayer()
    
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Methods
extension HabitCell {
    
    func setup(habit: Habit) {
        iconImageView.image = UIImage(named: habit.icon)
        habitNameLabel.text = habit.name.uppercased()
        setupShapeRing(days: habit.days)
    }
    
    
    fileprivate func setupShapeRing(days: Int) {
        let strokeEndValue = CGFloat(Double(days) / 66.0)
        let radius = frame.width / 2 - 30
        shapeRing = addRing(radius: radius, strokeColor: UIColor.appColor(color: .lightBlack), fillColor: .clear, strokeEnd: strokeEndValue)
        layer.addSublayer(shapeRing)
    }
    
    
    fileprivate func setupViews() {        
        iconContainer.backgroundColor = .clear
        addSubview(iconContainer)
        iconContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: frame.width - 40))
        
        let width = frame.width
        let iconDimensions = width / 2 - 30
        addSubview(iconImageView)
        iconImageView.center(in: iconContainer, size: .init(width: iconDimensions, height: iconDimensions))
        
        let radius = width / 2 - 30
        let trackRing = addRing(radius: radius, strokeColor:  .white, fillColor: .clear)
        
        layer.addSublayer(trackRing)
        
        addSubview(habitNameLabel)
        habitNameLabel.anchor(top: iconContainer.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 4, bottom: 0, right: 4))
    }
    
    
    fileprivate func addRing(radius: CGFloat, strokeColor: UIColor, fillColor: UIColor, lineWidth: CGFloat = 10, strokeEnd: CGFloat = 1) -> CAShapeLayer {
        let center = CGPoint(x: bounds.midX, y: bounds.midY - 20)
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
        
        let ring = CAShapeLayer()
        ring.path = circularPath.cgPath
        ring.strokeColor = strokeColor.cgColor
        ring.fillColor = fillColor.cgColor
        ring.lineCap = CAShapeLayerLineCap.round
        ring.lineWidth = lineWidth
        ring.strokeEnd = strokeEnd
        
        return ring
    }
}
