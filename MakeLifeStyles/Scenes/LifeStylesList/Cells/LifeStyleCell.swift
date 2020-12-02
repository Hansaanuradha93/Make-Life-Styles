import UIKit

class LifeStyleCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "LifeStyleCell"
    

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError() }
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
        contentView.backgroundColor = .blue
    }
}
