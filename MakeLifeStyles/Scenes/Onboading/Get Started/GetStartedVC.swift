import UIKit

class GetStartedVC: UIViewController {
    
    // MARK: Properties
    let circleImageView = LSImageView(image: Asserts.circle)
    let heroImageView = LSImageView(image: Asserts.personOnBicycle)
    let titleLabel = LSTitleLabel(textColor: UIColor.appColor(color: .lightBlack), numberOfLines: 2)
    let descriptionLabel = LSBodyLabel(text: Strings.areYouReady, textColor: UIColor.appColor(color: .greenishBlue), numberOfLines: 3)
    let callToActionButton = LSButton(backgroundColor: UIColor.appColor(color: .lightBlack), title: Strings.continueString, titleColor: .white, radius: 30)

    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK: - Methods
extension GetStartedVC {
    
    @objc fileprivate func handleCallToAction() {
        let controller = UserDetailsVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    fileprivate func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.appColor(color: .lightYellow)
        
        view.addSubview(circleImageView)
        circleImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: 35, height: 35))
        circleImageView.centerHorizontallyInSuperView()
        
        view.addSubview(heroImageView)
        heroImageView.anchor(top: circleImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: view.frame.height / 2))
        
        titleLabel.attributedText = NSMutableAttributedString().normal(Strings.itsTimeToBuild, 40).bold(Strings.someHabits, 40)
        view.addSubview(titleLabel)
        titleLabel.anchor(top: heroImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        callToActionButton.addTarget(self, action: #selector(handleCallToAction), for: .touchUpInside)
        view.addSubview(callToActionButton)
        callToActionButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20), size: .init(width: 0, height: 60))
    }
}
