import UIKit

class UserDetailsVC: UIViewController {

    let heroImageContainer = UIView()
    let detailsContainer = UIView()
    let circleImageView = LSImageView(image: Asserts.circle)
    let heroImageView = LSImageView(image: Asserts.personOnScooter)
    let nextButton = LSButton(backgroundColor: UIColor.appColor(color: .lightBlack), title: Strings.continueString, titleColor: .white, radius: 30)
    let backButton = LSButton(backgroundColor: UIColor.appColor(color: .darkestAsh), title: Strings.back, titleColor: UIColor.appColor(color: .lightAsh), radius: 30)
    let questionNumberLabel = LSBodyLabel(text: Strings.one, textColor: .white, fontSize: 25, textAlignment: .left)
    let questionLabel = LSBodyLabel(text: Strings.nameQuestion, textColor: .white, fontSize: 25, textAlignment: .left, numberOfLines: 2)
    let placeholderLabel = LSBodyLabel(text: Strings.enterYourName, textColor: UIColor.appColor(color: .lightAsh), fontSize: 16, textAlignment: .left)
    
    let nameTextField = UITextField()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)

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
        
        detailsContainer.addSubview(questionNumberLabel)
        questionNumberLabel.anchor(top: detailsContainer.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 30, bottom: 0, right: 0))
        
        detailsContainer.addSubview(questionLabel)
        questionLabel.anchor(top: questionNumberLabel.topAnchor, leading: questionNumberLabel.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 30))
        
        detailsContainer.addSubview(placeholderLabel)
        placeholderLabel.anchor(top: questionLabel.bottomAnchor, leading: questionLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0))
        
        nameTextField.backgroundColor = .white
        detailsContainer.addSubview(nameTextField)
        nameTextField.anchor(top: placeholderLabel.bottomAnchor, leading: questionNumberLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: view.frame.width - 100, height: 50))
        
        detailsContainer.addSubview(nextButton)
        nextButton.anchor(top: nil, leading: view.centerXAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 20), size: .init(width: 0, height: 60))
        
        detailsContainer.addSubview(backButton)
        backButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 10, right: 0), size: .init(width: 100, height: 60))
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc fileprivate func handleTap() {
        view.endEditing(true)
    }
    
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - nameTextField.frame.origin.y - nameTextField.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: (difference))
    }
    
    
    fileprivate func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
