import UIKit

class MakeHabitsVC: UIViewController {

    // MARK: Properties
    let titleLabel = LSTitleLabel(textColor: .white, fontSize: 28, textAlignment: .left)
    let saveButton = LSButton(backgroundColor: UIColor.appColor(color: .lightBlack), title: "SAVE", titleColor: .white, radius: 16, fontSize: 12)
    let nameLabel = LSBodyLabel(text: "Name your habit:", textColor: .white, fontSize: 20, textAlignment: .left)
    let nameTextField = LSTextField(backgroundColor: UIColor.appColor(color: .darkestAsh), textColor: .white, textSize: 20, borderStyle: .none, padding: 16)
    let typeLabel = LSBodyLabel(text: "Build or Quit this habit?", textColor: .white, fontSize: 20, textAlignment: .left)
    let buildButton = LSButton(backgroundColor: UIColor.appColor(color: .lightBlack), title: "Build", titleColor: .white, radius: 20, fontSize: 14)
    let quitButton = LSButton(backgroundColor: UIColor.appColor(color: .darkestAsh), title: "Quit", titleColor: .white, radius: 20, fontSize: 14)
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.appColor(color: .darkestAsh)
        return view
    }()
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaders()
        setupScrollView()
    }
}


// MARK: - Methods
extension MakeHabitsVC {
    
    @objc fileprivate func handleTap() {
        view.endEditing(true)
    }
    
    
    fileprivate func setupHeaders() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.appColor(color: .darkestAsh)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        view.addSubview(titleLabel)
        view.addSubview(saveButton)
        view.addSubview(scrollView)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 36, left: 20, bottom: 0, right: 0))
        saveButton.anchor(top: nil, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20), size: .init(width: 80, height: 32))
        saveButton.centerVertically(in: titleLabel)
        
        
        let attributedString = NSMutableAttributedString(string: "CREATE")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(2.5), range: NSRange(location: 0, length: attributedString.length))
        titleLabel.attributedText = attributedString
    }
    
    
    fileprivate func setupScrollView() {
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(typeLabel)
        scrollView.addSubview(buildButton)
        scrollView.addSubview(quitButton)
        
        nameTextField.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: 25)
        
        scrollView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        nameLabel.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 50, left: 20, bottom: 0, right: 20))
        nameTextField.anchor(top: nameLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0), size: .init(width: view.frame.width - 40, height: 50))
        typeLabel.anchor(top: nameTextField.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 36, left: 0, bottom: 0, right: 0))
        buildButton.anchor(top: typeLabel.bottomAnchor, leading: typeLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 40))
        quitButton.anchor(top: buildButton.topAnchor, leading: buildButton.trailingAnchor, bottom: buildButton.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 0), size: .init(width: buildButton.frame.width, height: 0))
    }
}
