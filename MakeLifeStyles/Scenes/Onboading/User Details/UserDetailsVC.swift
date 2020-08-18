import UIKit

class UserDetailsVC: UIViewController {

    let heroImageContainer = UIView()
    let detailsContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroImageContainer.backgroundColor = UIColor.appColor(color: .lightYellow)
        view.addSubview(heroImageContainer)
        heroImageContainer.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.centerYAnchor, trailing: view.trailingAnchor)
        
        detailsContainer.backgroundColor = UIColor.appColor(color: .darkestAsh)
        view.addSubview(detailsContainer)
        detailsContainer.anchor(top: view.centerYAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
