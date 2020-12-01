import UIKit

class HomeVC: UICollectionViewController {
    
    // MARK: Properties
    private let viewModel = HomeVM()
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addGestures()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchHabits()
    }
}


// MARK: - Collection View
extension HomeVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.habits.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCell.reuseID, for: indexPath) as! HabitCell
        cell.setup(habit: viewModel.habits[indexPath.item])
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habit = viewModel.habits[indexPath.item]
        let controller = HabitDetailsVC(viewModel: HabitDetailsVM(habit: habit))
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


// MARK: - Methods
extension HomeVC {
    
    @objc fileprivate func handleDoubleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let point = sender.location(in: collectionView)
            guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
            updateHabit(at: indexPath)
        }
    }
    
    
    func updateHabit(at indexPath: IndexPath) {
        let habit = viewModel.habits[indexPath.item]
        habit.days = habit.days + 1
        viewModel.updateHabit()
        collectionView.reloadItems(at: [indexPath])
    }
    
    
    fileprivate func fetchHabits() {
        viewModel.fetchHabits { [weak self] status in
            guard let self = self else { return }
            if status {
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
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
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Strings.home
        tabBarItem?.title = ""
        
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset.top = 30
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
