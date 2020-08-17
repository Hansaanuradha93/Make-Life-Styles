import UIKit

class LSButton: UIButton {

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    convenience init(backgroundColor: UIColor = .white, title: String = "", titleColor: UIColor = .black, radius: CGFloat = 0, fontSize: CGFloat = 20) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
        self.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: fontSize)
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.imageView?.contentMode = .scaleAspectFill
    }
}
