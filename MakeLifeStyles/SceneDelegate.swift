import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let isExistingUser = DataStore.shared.getUserStatus()
        let controller: UIViewController!

        if isExistingUser {
            controller = LSTabBar()
        } else {
            DataStore.shared.setUserStatus(isExistingUser: true)
            controller = UINavigationController(rootViewController: GetStartedVC())
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = controller
        self.window = window
        window.makeKeyAndVisible()
    }
    
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

