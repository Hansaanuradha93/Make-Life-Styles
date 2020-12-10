import UIKit

class LifeStyleCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "LifeStyleCell"
    
    private let gradientLayer = CAGradientLayer()
    private let titleLabel = LSTitleLabel(textColor: .white, fontSize: 35, numberOfLines: 0)
    private let daysValueLabel = LSTitleLabel(textColor: .white, fontSize: 110)
    private let daysLabel = LSBodyLabel(text: "DAYS", textColor: .white, fontSize: 40)
    private let iconImageView = LSImageView()

    
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
        titleLabel.text = habit.name
        daysValueLabel.text = "\(habit.daysValue)"
    }
}


// MARK: - Private Methods
private extension LifeStyleCell {
    
    func setupViews() {
        backgroundColor = .clear
        
        gradientLayer.colors = [AppColor.greenishBlue.cgColor, AppColor.lighestGreen.cgColor]
        gradientLayer.locations = [0, 1]
        layer.insertSublayer(gradientLayer, at: 0)
        
        iconImageView.image = iconImageView.image?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.appColor(color: .lightBlack)
        
        contentView.addSubviews(daysValueLabel, titleLabel, daysLabel, iconImageView)
        
        daysValueLabel.center(in: contentView)
        titleLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: daysValueLabel.topAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        daysLabel.centerHorizontally(in: contentView)
        daysLabel.anchor(top: daysValueLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        iconImageView.centerHorizontally(in: contentView)
        iconImageView.anchor(top: daysLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 100, height: 100))
    }
}
