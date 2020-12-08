import UIKit

class LifeStyleCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "LifeStyleCell"
    
    private let gradientLayer = CAGradientLayer()
    

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: Cell
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 20
    }
}


// MARK: - Public Methods
extension LifeStyleCell {
    
    func setup(habit: Habit) {
        print(habit)
    }
}


// MARK: - Private Methods
private extension LifeStyleCell {
    
    func setupViews() {
        backgroundColor = .clear
        gradientLayer.colors = [AppColor.greenishBlue.cgColor, AppColor.lighestGreen.cgColor]
        gradientLayer.locations = [0, 1]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
