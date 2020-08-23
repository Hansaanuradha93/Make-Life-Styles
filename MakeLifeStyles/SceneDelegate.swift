import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let isUsernameAvailable = false
        let controller: UIViewController!
        if isUsernameAvailable {
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

