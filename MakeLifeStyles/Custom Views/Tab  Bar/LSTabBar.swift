import UIKit

class LSTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.appColor(color: .pinkishRed)
        viewControllers = [createHomeNC(), createMakeHabbitsNC(), createLifeStylesListNC()]
    }
}


// MARK: - Methods
private extension LSTabBar {
    
    func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC(collectionViewLayout: UICollectionViewFlowLayout())
        homeVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.home, tag: 1)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createMakeHabbitsNC() -> UINavigationController {
        let makeHabitsVC = MakeHabitsVC()
        makeHabitsVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.add, tag: 0)
        return UINavigationController(rootViewController: makeHabitsVC)
    }
    
    
    func createLifeStylesListNC() -> UINavigationController {
        let lifeStylesListVC = LifeStylesListVC()
        lifeStylesListVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.star, tag: 2)
        return UINavigationController(rootViewController: lifeStylesListVC)
    }
}
