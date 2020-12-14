import UIKit

extension UIViewController {
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = LSEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    
    func presentLSAlertOnMainTread(title: String, message: String, buttonTitle: String, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertVC = LSAlertVC(title: title, message: message, buttonTitle: buttonTitle, action: action)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

