import UIKit

class HabbitCell: UICollectionViewCell {
    
    static let reuseID = "HabbitCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
