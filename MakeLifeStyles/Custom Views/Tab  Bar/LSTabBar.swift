import UIKit

class LSTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.appColor(color: .pinkishRed)
        viewControllers = [createSettingsNC(), createHomeNC(), createLifeStylesListNC()]
    }
}


// MARK: - Methods
extension LSTabBar {
    
    fileprivate func createSettingsNC() -> UINavigationController {
        let settingsVC = UIViewController()
        settingsVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.settings, tag: 0)
        return UINavigationController(rootViewController: settingsVC)
    }
    
    
    fileprivate func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC(collectionViewLayout: UICollectionViewFlowLayout())
        homeVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.home, tag: 1)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    fileprivate func createLifeStylesListNC() -> UINavigationController {
        let lifeStylesListVC = UIViewController()
        lifeStylesListVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.star, tag: 2)
        return UINavigationController(rootViewController: lifeStylesListVC)
    }
}
