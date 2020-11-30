import UIKit

class MakeHabitsVC: UIViewController {

    // MARK: Properties
    private let viewModel = MakeHabitsVM()
    
    private let nameLabel = LSBodyLabel(text: Strings.nameYourHabbit, textColor: .white, fontSize: 20, textAlignment: .left)
    private let nameTextField = LSTextField(backgroundColor: AppColor.darkestAsh, textColor: AppColor.lightAsh, textSize: 20, padding: 16)
    
    private let typeLabel = LSBodyLabel(text: Strings.buildOrQuitHabbit, textColor: .white, fontSize: 20, textAlignment: .left)
    private let buildButton = LSButton(backgroundColor: AppColor.lightBlack, title: Strings.build, titleColor: AppColor.lightAsh, radius: GlobalDimensions.cornerRadius, fontSize: 14)
    private let quitButton = LSButton(backgroundColor: AppColor.darkestAsh, title: Strings.quit, titleColor: AppColor.lightAsh, radius: GlobalDimensions.cornerRadius, fontSize: 14)
    
    private let numberOfDaysLabel = LSBodyLabel(text: Strings.howManyDays, textColor: .white, fontSize: 20, textAlignment: .left, numberOfLines: 0)
    private let numberOfDaysValueLabel = LSBodyLabel(text: Strings.oneDay, textColor: AppColor.lightAsh, fontSize: 18, textAlignment: .left, numberOfLines: 0)
    private let numberOfDaysIncrementStepper = UIStepper()
    
    private let setGoalLabel = LSBodyLabel(text: Strings.setYourGoal, textColor: .white, fontSize: 20, textAlignment: .left)
    private let setGoalTextField = LSTextField(text: Strings.one, backgroundColor: AppColor.darkestAsh, textColor: AppColor.lightAsh, textSize: 20, padding: 16)
    private let timePerWeekLabel = LSBodyLabel(text: Strings.moreTimesPerDay, textColor: AppColor.lightAsh, fontSize: 18, textAlignment: .left)
    
    private let saveButton = LSButton(backgroundColor: AppColor.darkestAsh, title: Strings.save, titleColor: AppColor.lightAsh, radius: GlobalDimensions.cornerRadius)

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = AppColor.darkestAsh
        return view
    }()
    
    private let contentView = UIView()
    private var overrallStackView = UIStackView()
    private var goalStackView = UIStackView()
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaders()
        setupScrollView()
        setupViews()
        customizeUIControlls()
        setupViewModelObserver()
    }
}


// MARK: - Objc Methods
private extension MakeHabitsVC {
    
    @objc func saveButtonTapped() {
        viewModel.saveHabit { [weak self] status, message in
            guard let self = self else { return }
            if status {
                self.presentLSAlertOnMainTread(title: Strings.successful, message: message, buttonTitle: Strings.ok)
            } else {
                self.presentLSAlertOnMainTread(title: Strings.failed, message: message, buttonTitle: Strings.ok)
            }
        }
        resetUI()
    }
    
    
    @objc func handleTextChange(textField: UITextField) {
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
    
    
    @objc func handleDaysIncrement(_ sender: UIStepper) {
        let value = Int(sender.value)
        viewModel.numberOfDays = value
        
        if value == 1 {
            numberOfDaysValueLabel.text = Strings.oneDay
        } else if value > 1 {
            numberOfDaysValueLabel.text = "\(value) \(Strings.days)"
        }
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
}


// MARK: - Private Methods
private extension MakeHabitsVC {
    
    func resetUI() {
        view.endEditing(true)
        
        viewModel.habitName = ""
        viewModel.isBuildHabit = true
        viewModel.numberOfDays = 1
        viewModel.goal = "1"
        
        nameTextField.text = ""
        changeButtons(isBuildClicked: true)
        numberOfDaysValueLabel.text = Strings.oneDay
        numberOfDaysIncrementStepper.value = 1
        setGoalTextField.text = "1"
    }
    
    
    func setupViewModelObserver() {
        viewModel.bindalbeIsFormValid.bind { [weak self] isFormValid in
            guard let self = self, let isFormValid = isFormValid else { return }
            if isFormValid {
                self.saveButton.backgroundColor = AppColor.lightBlack
                self.saveButton.setTitleColor(.white, for: .normal)
                self.saveButton.setRoundedBorder(radius: 25)
            } else {
                self.saveButton.backgroundColor = AppColor.darkestAsh
                self.saveButton.setTitleColor(UIColor.appColor(color: .lightAsh), for: .normal)
                self.saveButton.setRoundedBorder(borderColor: AppColor.lightAsh, borderWidth: 0.5, radius: 25)
            }
            self.saveButton.isEnabled = isFormValid
        }
    }
    
    
    func changeButtons(isBuildClicked: Bool) {
        UIView.animate(withDuration: 0.3) {
            if isBuildClicked {
                self.buildButton.backgroundColor = AppColor.lightBlack
                self.quitButton.backgroundColor = AppColor.darkestAsh
                self.setupViews()
            } else {
                self.buildButton.backgroundColor = AppColor.darkestAsh
                self.quitButton.backgroundColor = AppColor.lightBlack
                self.removeGoalView()
            }
        }
    }
    
    
    func removeGoalView() {
        overrallStackView.removeFully(view: setGoalLabel)
        overrallStackView.removeFully(view: goalStackView)
    }
    
    
    func setupHeaders() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Strings.create
        tabBarItem?.title = ""
        view.backgroundColor = AppColor.darkestAsh
        
        let attributesForLargeTitle = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributesForLargeTitle
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    func customizeUIControlls() {
        nameTextField.tintColor = UIColor.appColor(color: .lightAsh)
        nameTextField.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        nameTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        buildButton.addTarget(self, action: #selector(buildButtonTapped), for: .touchUpInside)
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        
        numberOfDaysIncrementStepper.autorepeat = true
        numberOfDaysIncrementStepper.value = 1
        numberOfDaysIncrementStepper.minimumValue = 1
        numberOfDaysIncrementStepper.addTarget(self, action: #selector(handleDaysIncrement), for: .valueChanged)
        
        setGoalTextField.tintColor = AppColor.lightAsh
        setGoalTextField.setRoundedBorder(borderColor: AppColor.lightAsh, borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        setGoalTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        setGoalTextField.keyboardType = .numberPad
                
        saveButton.isEnabled = false
        saveButton.setRoundedBorder(borderColor: AppColor.lightAsh, borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    
    func setupViews() {
        let spacing: CGFloat = 20
        let width: CGFloat = 70
        let height: CGFloat = GlobalDimensions.height
        
        nameTextField.setHeight(height)
        setGoalTextField.setWidth(width)
        setGoalTextField.setHeight(height)
        buildButton.setWidth(width)
        quitButton.setWidth(width)
        saveButton.setHeight(height)

        let buttonSpacingView = UIView()
        buttonSpacingView.backgroundColor = AppColor.darkestAsh
                
        let buttonStackView = UIStackView(arrangedSubviews: [buildButton, quitButton, buttonSpacingView])
        buttonStackView.spacing = spacing
        buttonStackView.alignment = .fill
        buttonStackView.setHeight(height)
        
        let initialDaysSpacingView = UIView()
        initialDaysSpacingView.backgroundColor = AppColor.darkestAsh
        
        let initialDaysStackView = UIStackView(arrangedSubviews: [numberOfDaysValueLabel, initialDaysSpacingView, numberOfDaysIncrementStepper])
        initialDaysStackView.spacing = spacing
        initialDaysStackView.alignment = .fill
        
        let goalSpacingView = UIView()
        goalSpacingView.backgroundColor = AppColor.darkestAsh
        
        goalStackView = UIStackView(arrangedSubviews: [setGoalTextField, timePerWeekLabel, goalSpacingView])
        goalStackView.spacing = spacing
        goalStackView.alignment = .fill
        
        overrallStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, typeLabel, buttonStackView, numberOfDaysLabel, initialDaysStackView, setGoalLabel, goalStackView, saveButton])
        overrallStackView.axis = .vertical
        overrallStackView.spacing = spacing
        
        contentView.addSubview(overrallStackView)
        overrallStackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 30, left: spacing, bottom: 0, right: spacing))
    }
    
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.fillSuperview()
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800)
        ])
    }
}
