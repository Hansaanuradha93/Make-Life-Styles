import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let isNewUser = DataStore.shared.getUserStatus()
        let controller: UIViewController!

        if isNewUser {
            DataStore.shared.setUserStatus(isNewUser: false)
            controller = LSTabBar()
        } else {
            controller = UINavigationController(rootViewController: GetStartedVC())
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = controller
        self.window = window
        window.makeKeyAndVisible()
    }
}

