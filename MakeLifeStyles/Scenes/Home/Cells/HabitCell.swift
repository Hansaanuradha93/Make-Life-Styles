import UIKit

class HabitCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "HabitCell"
    
    let iconContainer = UIView()
    let iconImageView = LSImageView(image: UIImage(named: "runner")!)
    let habitNameLabel = LSBodyLabel(text: "RUN 2.3 KM", textColor: .white, fontSize: 18)
    
    
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
        let shapeRing = addRing(radius: radius, strokeColor: UIColor.appColor(color: .lightBlack), fillColor: .clear, strokeEnd: 0.5)
        let trackRing = addRing(radius: radius, strokeColor:  .white, fillColor: .clear)
        
        layer.addSublayer(trackRing)
        layer.addSublayer(shapeRing)
        
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
