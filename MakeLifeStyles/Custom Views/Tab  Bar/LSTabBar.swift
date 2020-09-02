import UIKit

class LSTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.appColor(color: .pinkishRed)
        viewControllers = [createMakeHabbitsNC(), createHomeNC(), createLifeStylesListNC()]
    }
}


// MARK: - Methods
extension LSTabBar {
    
    fileprivate func createMakeHabbitsNC() -> UINavigationController {
        let makeHabitsVC = MakeHabitsVC()
        makeHabitsVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.add, tag: 0)
        return UINavigationController(rootViewController: makeHabitsVC)
    }
    
    
    fileprivate func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC(collectionViewLayout: UICollectionViewFlowLayout())
        homeVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.home, tag: 1)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    fileprivate func createLifeStylesListNC() -> UINavigationController {
        let lifeStylesListVC = LifeStylesListVC()
        lifeStylesListVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.star, tag: 2)
        return UINavigationController(rootViewController: lifeStylesListVC)
    }
}
