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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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


// MARK: - Private Methods
private extension LifeStylesVC {
    
    func fetchHabits() {
        viewModel.fetchHabits { [weak self] status in
            guard let self = self else { return }
            if status {
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
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
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
            
        return layout
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
