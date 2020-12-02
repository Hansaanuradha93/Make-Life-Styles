import UIKit

class LifeStylesVC: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}


// MARK: - Private Methods
private extension LifeStylesVC {
    
    func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributesForLargeTitle = [NSAttributedString.Key.foregroundColor : AppColor.lightBlack]
        navigationController?.navigationBar.largeTitleTextAttributes = attributesForLargeTitle
        title = Strings.lifeStyles
        tabBarItem?.title = ""
        
        collectionView.backgroundColor = .white
    }
}
