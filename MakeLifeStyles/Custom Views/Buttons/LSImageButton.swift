import UIKit

class LSImageButton: UIView {
    
    // MARK: Properties
    private let imageView = UIImageView()
    let button = UIButton()
        
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        createButton()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    convenience init(image: UIImage, tintColor: UIColor) {
        self.init(frame: .zero)
        self.setup(image: image, tintColor: tintColor)
    }
}


// MARK: - Private Methods
private extension LSImageButton {
    
    func setup(image: UIImage, tintColor: UIColor) {
        self.imageView.image = image
        self.imageView.contentMode = .scaleAspectFill
        self.tintColor = tintColor
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    
    func createButton() {
        addSubviews(imageView, button)
        
        imageView.fillSuperview()
        button.fillSuperview()
    }
}
