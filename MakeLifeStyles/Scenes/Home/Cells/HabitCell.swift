import UIKit

class HabitCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "HabbitCell"
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Methods
extension HabitCell {
    
    fileprivate func setupViews() {
        backgroundColor = .yellow
        
        let radius = frame.width / 2 - 30
        let shapeRing = addRing(radius: radius, strokeColor: UIColor.appColor(color: .pinkishRed), fillColor: .clear, strokeEnd: 0.5)
        let trackRing = addRing(radius: radius, strokeColor:  UIColor.appColor(color: .lightBlack), fillColor: .clear)
        
        layer.addSublayer(trackRing)
        layer.addSublayer(shapeRing)
    }
    
    
    fileprivate func addRing(radius: CGFloat, strokeColor: UIColor, fillColor: UIColor, lineWidth: CGFloat = 10, strokeEnd: CGFloat = 1) -> CAShapeLayer {
        let center = CGPoint(x: bounds.midX, y: bounds.midY - 20)
        let ring = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        ring.path = circularPath.cgPath
        ring.strokeColor = strokeColor.cgColor
        ring.fillColor = fillColor.cgColor
        ring.lineCap = CAShapeLayerLineCap.round
        ring.lineWidth = lineWidth
        ring.strokeEnd = strokeEnd
        
        return ring
    }
}
