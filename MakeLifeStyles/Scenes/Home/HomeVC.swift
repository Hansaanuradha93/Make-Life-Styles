import UIKit

class HomeVC: UICollectionViewController {
    
    lazy var habits = [
        Habit(icon: "runner", name: "run 2.3 km", days: 7),
        Habit(icon: "smoke", name: "don't smoke", days: 22),
        Habit(icon: "carrot", name: "eat a healthy meal", days: 55),
        Habit(icon: "dog", name: "walk the dog", days: 66),
        Habit(icon: "temple", name: "worship", days: 72)
    ]

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK: - Collection View
extension HomeVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCell.reuseID, for: indexPath) as! HabitCell
        cell.setup(habit: habits[indexPath.item])
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
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
        collectionView.register(HabitCell.self, forCellWithReuseIdentifier: HabitCell.reuseID)
    }
}
