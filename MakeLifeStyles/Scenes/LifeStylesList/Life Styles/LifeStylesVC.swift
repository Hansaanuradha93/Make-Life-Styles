import UIKit

class LifeStylesVC: UIViewController {
    
    // MARK: Properties
    private let viewModel = LifeStylesVM()
    
    private var collectionView: UICollectionView!
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addGestures()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToFirstHabit()
        fetchHabits()
    }
}


// MARK: - Collection View
extension LifeStylesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.habits.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LifeStyleCell.reuseID, for: indexPath) as! LifeStyleCell
        cell.setup(habit: viewModel.habits[indexPath.item])
        return cell
    }
}


// MARK: - UIGestureRecognizerDelegate
extension LifeStylesVC: UIGestureRecognizerDelegate {
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != .began {
            return
        }
        let point = gestureReconizer.location(in: collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        if let index = indexPath {
            let habit = viewModel.habits[index.item]
            print(habit.name)
        }
    }
}


// MARK: - Private Methods
private extension LifeStylesVC {
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let point = sender.location(in: collectionView)
            guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
            updateHabit(at: indexPath)
            print()
        }
    }
    
    
    func updateHabit(at indexPath: IndexPath) {
        let habit = viewModel.habits[indexPath.item]
        habit.days = habit.days + 1
        habit.updatedAt = Date()
        viewModel.updateHabit()
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    
    func fetchHabits() {
        viewModel.fetchHabits { [weak self] status in
            guard let self = self else { return }
            if status {
                self.updateUI(with: self.viewModel.habits)
            }
        }
    }
    
    
    func updateUI(with habit: [Habit]) {
        if self.viewModel.habits.isEmpty {
            let message = Strings.noLifestylesYet
            DispatchQueue.main.async { self.showEmptyStateView(image: Asserts.personOnScooter, with: message, in: self.view) }
            return
        }
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.collectionView)
            self.collectionView.reloadData()
        }
    }
    
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets.trailing = 30
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.65))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            return section
        }
            
        return layout
    }
    
    
    func scrollToFirstHabit() {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
    }
    
    
    func addGestures() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.delaysTouchesBegan = true
        view.addGestureRecognizer(gestureRecognizer)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delaysTouchesBegan = true
        longPressGesture.delegate = self
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    
    func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributesForLargeTitle = [NSAttributedString.Key.foregroundColor : AppColor.lightBlack]
        navigationController?.navigationBar.largeTitleTextAttributes = attributesForLargeTitle
        title = Strings.lifeStyles
        tabBarItem?.title = ""
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 0)
        collectionView.register(LifeStyleCell.self, forCellWithReuseIdentifier: LifeStyleCell.reuseID)
    }
}
