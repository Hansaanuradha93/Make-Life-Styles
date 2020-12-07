import UIKit

extension UIViewController {
    
    func presentLSAlertOnMainTread(title: String, message: String, buttonTitle: String, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertVC = LSAlertVC(title: title, message: message, buttonTitle: buttonTitle, action: action)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

