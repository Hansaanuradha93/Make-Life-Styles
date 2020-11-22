import UIKit

extension UIViewController {
    
    func presentLSAlertOnMainTread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = LSAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

