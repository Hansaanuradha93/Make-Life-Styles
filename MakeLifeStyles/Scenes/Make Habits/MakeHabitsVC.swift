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
    let numberOfDaysLabel = LSBodyLabel(text: "How many days you have been doing this?", textColor: .white, fontSize: 20, textAlignment: .left, numberOfLines: 0)
    let numberOfDaysValueLabel = LSBodyLabel(text: "1 Day", textColor: .white, fontSize: 18, textAlignment: .left, numberOfLines: 0)
    let numberOfDaysIncrementStepper = UIStepper (frame:CGRect(x: 10, y: 150, width: 0, height: 0))


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
    
    @objc func quitButtonTapped() {
        changeButtons(isBuildClicked: false)
    }
    
    
    @objc func buildButtonTapped() {
        changeButtons(isBuildClicked: true)
    }
    
    
    @objc fileprivate func handleDaysIncrement(_ sender: UIStepper) {
        let value = Int(sender.value)
        if value == 1 {
            numberOfDaysValueLabel.text = "1 Day"
        } else if value > 1 {
            numberOfDaysValueLabel.text = "\(value) Days"
        }
    }
    
    @objc fileprivate func handleTap() {
        view.endEditing(true)
    }
    
    
    fileprivate func changeButtons(isBuildClicked: Bool) {
        UIView.animate(withDuration: 0.3) {
            if isBuildClicked {
                self.quitButton.backgroundColor = UIColor.appColor(color: .darkestAsh)
                self.buildButton.backgroundColor = UIColor.appColor(color: .lightBlack)
            } else {
                self.buildButton.backgroundColor = UIColor.appColor(color: .darkestAsh)
                self.quitButton.backgroundColor = UIColor.appColor(color: .lightBlack)
            }
        }
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
        scrollView.addSubview(numberOfDaysLabel)
        scrollView.addSubview(numberOfDaysValueLabel)
        scrollView.addSubview(numberOfDaysIncrementStepper)
        
        let textFieldsDimensions = CGSize(width: view.frame.width - 40, height: 50)
        let controlButtonsDimensions = CGSize(width: 100, height: 40)
        
        nameTextField.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: 25)
        
        buildButton.addTarget(self, action: #selector(buildButtonTapped), for: .touchUpInside)
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        
        numberOfDaysIncrementStepper.autorepeat = true
        numberOfDaysIncrementStepper.value = 1
        numberOfDaysIncrementStepper.minimumValue = 1
        numberOfDaysIncrementStepper.addTarget(self, action: #selector(handleDaysIncrement), for: .valueChanged)
        
        scrollView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        nameLabel.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 50, left: 20, bottom: 0, right: 20))
        nameTextField.anchor(top: nameLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0), size: textFieldsDimensions)
        
        typeLabel.anchor(top: nameTextField.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: 0, bottom: 0, right: 0))
        buildButton.anchor(top: typeLabel.bottomAnchor, leading: typeLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: controlButtonsDimensions)
        quitButton.anchor(top: buildButton.topAnchor, leading: buildButton.trailingAnchor, bottom: buildButton.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 0), size: controlButtonsDimensions)
        
        numberOfDaysLabel.anchor(top: buildButton.bottomAnchor, leading: nameTextField.leadingAnchor, bottom: nil, trailing: nameTextField.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: textFieldsDimensions)
        numberOfDaysValueLabel.anchor(top: numberOfDaysLabel.bottomAnchor, leading: numberOfDaysLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        numberOfDaysIncrementStepper.anchor(top: nil, leading: numberOfDaysValueLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 0))
        numberOfDaysIncrementStepper.centerVertically(in: numberOfDaysValueLabel)
    }
}
