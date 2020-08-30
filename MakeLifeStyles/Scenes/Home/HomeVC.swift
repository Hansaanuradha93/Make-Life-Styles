import UIKit

class HomeVC: UICollectionViewController {
    
    // MARK: Properties
    lazy var habits = [
        Habit(icon: "runner", name: "run 2.3 km", days: 7),
        Habit(icon: "smoke", name: "don't smoke", days: 22),
        Habit(icon: "carrot", name: "eat a healthy meal", days: 55),
        Habit(icon: "dog", name: "walk the dog", days: 60),
        Habit(icon: "temple", name: "worship", days: 64)
    ]

    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addGestures()
    }
}


// MARK: - Collection View
extension HomeVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habits.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCell.reuseID, for: indexPath) as! HabitCell
        cell.setup(habit: habits[indexPath.item])
        return cell
    }
}


// MARK: - Methods
extension HomeVC {
    
    @objc fileprivate func handleDoubleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let point = sender.location(in: collectionView)
            guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
            habits[indexPath.item].days = habits[indexPath.item].days + 1
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    
    fileprivate func addGestures() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.delaysTouchesBegan = true
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    
    fileprivate func setupUI() {
        navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = UIColor.appColor(color: .pinkishRed)
        
        collectionView.contentInset.top = 70
        collectionView.register(HabitCell.self, forCellWithReuseIdentifier: HabitCell.reuseID)
        
        guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        let dimenstions = (collectionView.frame.width) / 2
        collectionViewLayout.itemSize = CGSize(width: dimenstions, height: dimenstions)
        collectionViewLayout.invalidateLayout()
    }
}
