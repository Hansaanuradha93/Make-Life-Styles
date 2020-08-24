import UIKit

class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabbitCell.reuseID, for: indexPath) as! HabbitCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimenstions = (collectionView.frame.width - 10) / 2
        return CGSize(width: dimenstions, height: dimenstions)
    }
}


// MARK: - Methods
extension HomeVC {
    
    fileprivate func setupUI() {
        navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = .white
        
        collectionView.contentInset.top = 70
        collectionView.register(HabbitCell.self, forCellWithReuseIdentifier: HabbitCell.reuseID)
    }
}
