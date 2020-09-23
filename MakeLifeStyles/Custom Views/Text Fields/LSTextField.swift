import UIKit

class LSTextField: UITextField {
    
    // MARK: Properties
    fileprivate var padding: CGFloat = 0
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(backgroundColor: UIColor = .white, textColor: UIColor = .black, textSize: CGFloat, borderStyle: UITextField.BorderStyle = .line, padding: CGFloat = 0, placeholderText: String = "") {
        self.init()
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = UIFont(name: "AvenirNext-Regular", size: textSize)
        self.borderStyle = borderStyle
        self.padding = padding
        self.placeholder = placeholderText
    }
    
    
    required init?(coder: NSCoder) { fatalError() }

    
    // MARK: Overridden Methods
    override func editingRect(forBounds bounds: CGRect) -> CGRect { return bounds.insetBy(dx: padding, dy: 0) }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect { return bounds.insetBy(dx: padding, dy: 0) }
}
