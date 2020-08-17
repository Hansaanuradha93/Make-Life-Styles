import UIKit

class GetStartedVC: UIViewController {
    
    let circleImageView = UIImageView()
    let heroImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let callToActionButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.appColor(color: .lightYellow)
        
        circleImageView.image = UIImage(named: "circle")
        circleImageView.contentMode = .scaleAspectFill
        view.addSubview(circleImageView)
        circleImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: 35, height: 35))
        circleImageView.centerHorizontallyInSuperView()
        
        heroImageView.image = UIImage(named: "person_on_bicycle")
        heroImageView.contentMode = .scaleAspectFill
        view.addSubview(heroImageView)
        heroImageView.anchor(top: circleImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: view.frame.height / 2))
        
        titleLabel.attributedText = NSMutableAttributedString().normal("It's time to build\n", 40).bold("some habits!", 40)
        titleLabel.textColor = UIColor.appColor(color: .lightBlack)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
        titleLabel.anchor(top: heroImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        descriptionLabel.text = "Are you ready?\nNow we gonna build your\n morning routine!"
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textColor = UIColor.appColor(color: .greenishBlue)
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        
        callToActionButton.setTitle("Continue", for: .normal)
        callToActionButton.setTitleColor(.white, for: .normal)
        callToActionButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        callToActionButton.backgroundColor = UIColor.appColor(color: .lightBlack)
        callToActionButton.layer.cornerRadius = 65 / 2
        view.addSubview(callToActionButton)
        callToActionButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20), size: .init(width: 0, height: 65))
    }
}
