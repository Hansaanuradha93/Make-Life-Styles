import UIKit

class UserDetailsVC: UIViewController {

    let heroImageContainer = UIView()
    let detailsContainer = UIView()
    let circleImageView = LSImageView(image: Asserts.circle)
    let heroImageView = LSImageView(image: Asserts.personOnScooter)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true // remove this line

        
        heroImageContainer.backgroundColor = UIColor.appColor(color: .lightYellow)
        view.addSubview(heroImageContainer)
        heroImageContainer.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.centerYAnchor, trailing: view.trailingAnchor)
        
        detailsContainer.backgroundColor = UIColor.appColor(color: .darkestAsh)
        view.addSubview(detailsContainer)
        detailsContainer.anchor(top: view.centerYAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        heroImageContainer.addSubview(circleImageView)
        circleImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: 35, height: 35))
        circleImageView.centerHorizontallyInSuperView()
        
        heroImageContainer.addSubview(heroImageView)
        heroImageView.anchor(top: circleImageView.bottomAnchor, leading: view.leadingAnchor, bottom: heroImageContainer.bottomAnchor, trailing: view.trailingAnchor)
    }
}
