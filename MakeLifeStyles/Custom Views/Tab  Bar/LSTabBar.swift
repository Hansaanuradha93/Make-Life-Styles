import UIKit

class LSTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createHomeNC(), createFavouriteListNC()]
    }
}


// MARK: - Methods
extension LSTabBar {
    
    fileprivate func createHomeNC() -> UINavigationController {
        let searchVC = HomeVC()
        searchVC.title = "Home"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    fileprivate func createFavouriteListNC() -> UINavigationController {
        let favouriteListVC = UIViewController()
        favouriteListVC.title           = "Favourites"
        favouriteListVC.tabBarItem      = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouriteListVC)
    }
}
