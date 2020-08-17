import UIKit

class LSBodyLabel: UILabel {

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    convenience init(text: String = "", textColor: UIColor = .black, fontSize: CGFloat = 18, textAlignment: NSTextAlignment = .center, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont(name: "AvenirNext-Regular", size: fontSize)
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}


// MARK: - Private Methods
extension LSBodyLabel {
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }
}
