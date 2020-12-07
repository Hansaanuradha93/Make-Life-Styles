import UIKit

class LifeStylesVC: UIViewController {
    
    // MARK: Properties
    private let viewModel = LifeStylesVM()
    
    private var collectionView: UICollectionView!
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}


// MARK: - Collection View
extension LifeStylesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LifeStyleCell.reuseID, for: indexPath) as! LifeStyleCell
        return cell
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
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.register(LifeStyleCell.self, forCellWithReuseIdentifier: LifeStyleCell.reuseID)
    }
}
