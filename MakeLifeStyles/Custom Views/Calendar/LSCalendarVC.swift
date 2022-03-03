import UIKit

class LSCalendarVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.minimumLineSpacing = 0
      layout.minimumInteritemSpacing = 0
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.isScrollEnabled = false
//      collectionView.translatesAutoresizingMaskIntoConstraints = false
      return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemGroupedBackground

        view.addSubview(collectionView)
        
        collectionView.fillSuperview()
    }
}
