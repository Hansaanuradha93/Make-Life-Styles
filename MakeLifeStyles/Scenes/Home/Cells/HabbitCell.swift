import UIKit

class HabbitCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "HabbitCell"
    
    fileprivate var shapeRing = CAShapeLayer()
    fileprivate var trackRing = CAShapeLayer()
    fileprivate  var radius: CGFloat = 0
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addRings()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Methods
extension HabbitCell {
    
    fileprivate func addRings() {
        backgroundColor = .yellow
        radius = frame.width / 2 - 30
        trackRing = addRing(radius: radius, strokeColor:  UIColor.appColor(color: .lightBlack), fillColor: .clear)
        shapeRing = addRing(radius: radius, strokeColor: UIColor.appColor(color: .pinkishRed), fillColor: .clear, strokeEnd: 0.5)
        
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
