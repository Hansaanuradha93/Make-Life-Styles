import UIKit

class MakeHabitsVC: UIViewController {

    // MARK: Properties
    private let viewModel = MakeHabitsVM()
    
    private let titleLabel = LSTitleLabel(textColor: .white, fontSize: 28, textAlignment: .left)
    private let nameLabel = LSBodyLabel(text: "Name your habit:", textColor: .white, fontSize: 20, textAlignment: .left)
    private let nameTextField = LSTextField(backgroundColor: UIColor.appColor(color: .darkestAsh), textColor: UIColor.appColor(color: .lightAsh), textSize: 20, borderStyle: .none, padding: 16)
    
    private let typeLabel = LSBodyLabel(text: "Build or Quit this habit?", textColor: .white, fontSize: 20, textAlignment: .left)
    private let buildButton = LSButton(backgroundColor: UIColor.appColor(color: .lightBlack), title: "Build", titleColor: UIColor.appColor(color: .lightAsh), radius: 25, fontSize: 14)
    private let quitButton = LSButton(backgroundColor: UIColor.appColor(color: .darkestAsh), title: "Quit", titleColor: UIColor.appColor(color: .lightAsh), radius: 25, fontSize: 14)
    
    private let numberOfDaysLabel = LSBodyLabel(text: "How many days you have been doing this?", textColor: .white, fontSize: 20, textAlignment: .left, numberOfLines: 0)
    private let numberOfDaysValueLabel = LSBodyLabel(text: "1 Day", textColor: UIColor.appColor(color: .lightAsh), fontSize: 18, textAlignment: .left, numberOfLines: 0)
    private let numberOfDaysIncrementStepper = UIStepper (frame:CGRect(x: 10, y: 150, width: 0, height: 0))
    
    private let setGoalLabel = LSBodyLabel(text: "Set your goal:", textColor: .white, fontSize: 20, textAlignment: .left)
    private let setGoalTextField = LSTextField(text: "1", backgroundColor: UIColor.appColor(color: .darkestAsh), textColor: UIColor.appColor(color: .lightAsh), textSize: 20, borderStyle: .none, padding: 16)
    private let timePerWeekLabel = LSBodyLabel(text: "Or more times per week", textColor: UIColor.appColor(color: .lightAsh), fontSize: 18, textAlignment: .left)
    
    private let groupLabel = LSBodyLabel(text: "Group:", textColor: .white, fontSize: 20, textAlignment: .left)
//    let picker = UIPickerView()
    private let groupTextField = LSTextField(text: "None", backgroundColor: UIColor.appColor(color: .darkestAsh), textColor: UIColor.appColor(color: .lightAsh), textSize: 20, borderStyle: .none, padding: 16)
    private let arrowImage = LSImageView(image: UIImage(systemName: "arrow.down")!)

    
    private let saveButton = LSButton(backgroundColor: UIColor.appColor(color: .darkestAsh), title: "SAVE", titleColor: UIColor.appColor(color: .lightAsh), radius: 25, fontSize: 12)

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.appColor(color: .darkestAsh)
        return view
    }()
    
    private let contentView = UIView()
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaders()
        setupScrollView()
        customizeUIControlls()
        setupViewModelObserver()
    }
}


// MARK: - Methods
extension MakeHabitsVC {
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        viewModel.habitName = nameTextField.text
        viewModel.goal = setGoalTextField.text
    }
    
    
    @objc func quitButtonTapped() {
        changeButtons(isBuildClicked: false)
        viewModel.isBuildHabit = false
    }
    
    
    @objc func buildButtonTapped() {
        changeButtons(isBuildClicked: true)
        viewModel.isBuildHabit = true
    }
    
    
    @objc fileprivate func handleDaysIncrement(_ sender: UIStepper) {
        let value = Int(sender.value)
        viewModel.numberOfDays = value
        
        if value == 1 {
            numberOfDaysValueLabel.text = "1 Day"
        } else if value > 1 {
            numberOfDaysValueLabel.text = "\(value) Days"
        }
    }
    
    
    @objc fileprivate func handleTap() {
        view.endEditing(true)
    }
    
    
    fileprivate func setupViewModelObserver() {
        viewModel.bindalbeIsFormValid.bind { [weak self] isFormValid in
            guard let self = self, let isFormValid = isFormValid else { return }
            if isFormValid {
                self.saveButton.backgroundColor = UIColor.appColor(color: .lightBlack)
                self.saveButton.setTitleColor(.white, for: .normal)
                self.saveButton.setRoundedBorder(radius: 25)
            } else {
                self.saveButton.backgroundColor = UIColor.appColor(color: .darkestAsh)
                self.saveButton.setTitleColor(UIColor.appColor(color: .lightAsh), for: .normal)
                self.saveButton.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: 25)
            }
            self.saveButton.isEnabled = isFormValid
        }
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
        
        view.addSubviews(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 36, left: 20, bottom: 0, right: 0))
        
        let attributedString = NSMutableAttributedString(string: "CREATE")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(2.5), range: NSRange(location: 0, length: attributedString.length))
        titleLabel.attributedText = attributedString
    }
    
    
    fileprivate func customizeUIControlls() {
        nameTextField.tintColor = UIColor.appColor(color: .lightAsh)
        nameTextField.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: 25)
        nameTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        buildButton.addTarget(self, action: #selector(buildButtonTapped), for: .touchUpInside)
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        
        numberOfDaysIncrementStepper.autorepeat = true
        numberOfDaysIncrementStepper.value = 1
        numberOfDaysIncrementStepper.minimumValue = 1
        numberOfDaysIncrementStepper.addTarget(self, action: #selector(handleDaysIncrement), for: .valueChanged)
        
        setGoalTextField.tintColor = UIColor.appColor(color: .lightAsh)
        setGoalTextField.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: 25)
        setGoalTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        setGoalTextField.keyboardType = .numberPad
        
        groupTextField.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: 25)
        arrowImage.image = arrowImage.image?.withRenderingMode(.alwaysTemplate)
        arrowImage.tintColor = UIColor.appColor(color: .lightAsh)
        
//        picker.dataSource = self
//        picker.delegate = self
        
        saveButton.isEnabled = false
        saveButton.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: 25)
    }
    
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        let textFieldsDimensions = CGSize(width: view.frame.width - 40, height: 50)
        let controlButtonsDimensions = CGSize(width: 70, height: 50)
        
        scrollView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800)
        ])
        
        contentView.addSubviews(nameLabel, nameTextField, typeLabel, buildButton, quitButton, numberOfDaysLabel, numberOfDaysValueLabel, numberOfDaysIncrementStepper, setGoalLabel, setGoalTextField, timePerWeekLabel, groupLabel, groupTextField, arrowImage, saveButton)
        
        nameLabel.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 20))
        nameTextField.anchor(top: nameLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0), size: textFieldsDimensions)
        
        typeLabel.anchor(top: nameTextField.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: 0, bottom: 0, right: 0))
        buildButton.anchor(top: typeLabel.bottomAnchor, leading: typeLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: controlButtonsDimensions)
        quitButton.anchor(top: buildButton.topAnchor, leading: buildButton.trailingAnchor, bottom: buildButton.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 0), size: controlButtonsDimensions)
        
        numberOfDaysLabel.anchor(top: buildButton.bottomAnchor, leading: nameTextField.leadingAnchor, bottom: nil, trailing: nameTextField.trailingAnchor, padding: .init(top: 26, left: 0, bottom: 0, right: 0))
        numberOfDaysValueLabel.anchor(top: numberOfDaysLabel.bottomAnchor, leading: numberOfDaysLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 16, bottom: 0, right: 0))
        numberOfDaysIncrementStepper.anchor(top: nil, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        numberOfDaysIncrementStepper.centerVertically(in: numberOfDaysValueLabel)
        
        setGoalLabel.anchor(top: numberOfDaysIncrementStepper.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: 20, bottom: 0, right: 0))
        setGoalTextField.anchor(top: setGoalLabel.bottomAnchor, leading: nameTextField.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 70, height: 50))
        timePerWeekLabel.anchor(top: nil, leading: setGoalTextField.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        timePerWeekLabel.centerVertically(in: setGoalTextField)
        
        groupLabel.anchor(top: setGoalTextField.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: 20, bottom: 0, right: 0))
        groupTextField.anchor(top: groupLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0), size: textFieldsDimensions)
        arrowImage.anchor(top: nil, leading: nil, bottom: nil, trailing: groupTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20), size: .init(width: 15, height: 15))
        arrowImage.centerVertically(in: groupTextField)
//        picker.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        saveButton.anchor(top: groupTextField.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: 20, bottom: 0, right: 20), size: textFieldsDimensions)
    }
}

// MARK: -
extension MakeHabitsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
}
