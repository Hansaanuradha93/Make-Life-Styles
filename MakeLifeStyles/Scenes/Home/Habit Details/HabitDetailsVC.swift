import UIKit

class HabitDetailsVC: KeyboardHandlingVC {

    // MARK: Perperties
    private var viewModel: HabitDetailsVM!
    
    private let nameLabel = LSBodyLabel(text: Strings.habit, textColor: AppColor.darkestAsh, fontSize: 20, textAlignment: .left)
    private let nameTextField = LSTextField(textColor: AppColor.lightAsh, textSize: 20, padding: 16)
    
    private let typeLabel = LSBodyLabel(text: Strings.habitType, textColor: AppColor.darkestAsh, fontSize: 20, textAlignment: .left)
    private let buildButton = LSButton(backgroundColor: AppColor.lightBlack, title: Strings.build, titleColor: .white, radius: GlobalDimensions.cornerRadius, fontSize: 14)
    private let quitButton = LSButton(backgroundColor: .white, title: Strings.quit, titleColor: AppColor.lightBlack, radius: GlobalDimensions.cornerRadius, fontSize: 14)
    
    private let numberOfDaysLabel = LSBodyLabel(text: Strings.numberOfDays, textColor: AppColor.darkestAsh, fontSize: 20, textAlignment: .left, numberOfLines: 0)
    private let numberOfDaysValueLabel = LSBodyLabel(text: Strings.oneDay, textColor: AppColor.lightAsh, fontSize: 18, textAlignment: .left, numberOfLines: 0)
    private let numberOfDaysIncrementStepper = UIStepper()
    
    private let setGoalLabel = LSBodyLabel(text: Strings.goal, textColor: AppColor.darkestAsh, fontSize: 20, textAlignment: .left)
    private let setGoalTextField = LSTextField(text: Strings.one, backgroundColor: .white, textColor: AppColor.lightAsh, textSize: 20, padding: 16)
    private let timePerWeekLabel = LSBodyLabel(text: Strings.moreTimesPerDay, textColor: AppColor.lightAsh, fontSize: 18, textAlignment: .left)
    
    private let updateButton = LSButton(backgroundColor: .white, title: Strings.update, titleColor: AppColor.darkestAsh, radius: GlobalDimensions.cornerRadius)
    private let deleteButton = LSButton(backgroundColor: .white, title: Strings.delete, titleColor: AppColor.pinkishRed, radius: GlobalDimensions.cornerRadius)

    private let contentView = UIView()
    private var overrallStackView = UIStackView()
    private var goalStackView = UIStackView()
    
    
    // MARK: Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    convenience init(viewModel: HabitDetailsVM) {
        self.init()
        self.viewModel = viewModel
    }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaders()
        setupScrollView()
        setupViews()
        customizeUIControlls()
        setupViewModelObserver()
        setData()
    }
}


// MARK: - Objc Methods
private extension HabitDetailsVC {
    
    @objc func updateButtonTapped() {
        updateHabit()
    }
    
    
    @objc func deleteButtonTapped() {
        presentConfirmAlertOnMainTread(title: Strings.doYouWantToDeleteThisHabit, message: Strings.youCannotUndoThisAction, cancelButtonTitle: Strings.cancel, actionButtonTitle: Strings.delete, action:  {
            self.deleteHabit()
        })
    }
    
    
    @objc func handleTextChange(textField: UITextField) {
        viewModel.isUpdating = true
        viewModel.habitName = nameTextField.text
        viewModel.goal = setGoalTextField.text
    }
    
    
    @objc func quitButtonTapped() {
        changeButtons(isBuildClicked: false)
        viewModel.isUpdating = true
        viewModel.isBuildHabit = false
    }
    
    
    @objc func buildButtonTapped() {
        changeButtons(isBuildClicked: true)
        viewModel.isUpdating = true
        viewModel.isBuildHabit = true
    }
    
    
    @objc func handleDaysIncrement(_ sender: UIStepper) {
        let value = Int(sender.value)
        viewModel.isUpdating = true
        viewModel.numberOfDays = value
        
        if value == 1 {
            numberOfDaysValueLabel.text = Strings.oneDay
        } else if value > 1 {
            numberOfDaysValueLabel.text = "\(value) \(Strings.days)"
        }
    }
}


// MARK: - Private Methods
private extension HabitDetailsVC {
    
    func deleteHabit() {
        viewModel.deleteHabit { (status, message) in
            if status {
                self.presentAlertOnMainTread(title: Strings.successful, message: message, buttonTitle: Strings.ok) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
    func updateHabit() {
        viewModel.updateHabit { [weak self] status, title, message, tabIndex in
            guard let self = self else { return }
            if status {
                self.presentAlertOnMainTread(title: title, message: message, buttonTitle: Strings.ok) {
                    self.updateUI(with: tabIndex)
                }
            } else {
                self.presentAlertOnMainTread(title: title, message: message, buttonTitle: Strings.ok)
            }
        }
        resetUI()
    }
    
    
    func updateUI(with tabIndex: Int?) {
        if let tabIndex = tabIndex {
            self.tabBarController?.selectedIndex = tabIndex
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setData() {
        let habit = viewModel.habit
        
        nameTextField.text = habit.name
        changeButtons(isBuildClicked: habit.habitType)
        setGoalTextField.text = "\(habit.repetitionsValue)"
        numberOfDaysValueLabel.text = viewModel.numberOfDaysString
        
        viewModel.isUpdating = false
        viewModel.habitName = habit.name
        viewModel.isBuildHabit = habit.habitType
        viewModel.numberOfDays = habit.daysValue
        viewModel.goal = "\(habit.repetitionsValue)"
    }
    
    
    func resetNavigationBar() {
        let attributesForLargeTitle = [NSAttributedString.Key.foregroundColor : AppColor.lightBlack]
        navigationController?.navigationBar.largeTitleTextAttributes = attributesForLargeTitle
    }
    
    
    func resetUI() {
        view.endEditing(true)
        viewModel.isUpdating = false
    }
    
    
    func setupViewModelObserver() {
        viewModel.bindalbeIsFormValid.bind { [weak self] isFormValid in
            guard let self = self, let isFormValid = isFormValid else { return }
            if isFormValid {
                self.updateButton.backgroundColor = AppColor.lightBlack
                self.updateButton.setTitleColor(.white, for: .normal)
                self.updateButton.setRoundedBorder(radius: GlobalDimensions.cornerRadius)
            } else {
                self.updateButton.backgroundColor = .white
                self.updateButton.setTitleColor(AppColor.lightBlack, for: .normal)
                self.updateButton.setRoundedBorder(borderColor: AppColor.lightBlack, borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
            }
            self.updateButton.isEnabled = isFormValid
        }
    }
    
    
    func changeButtons(isBuildClicked: Bool) {
        UIView.animate(withDuration: 0.3) {
            if isBuildClicked {
                self.buildButton.backgroundColor = AppColor.lightBlack
                self.buildButton.setTitleColor(.white, for: .normal)
                self.quitButton.backgroundColor = .white
                self.quitButton.setTitleColor(AppColor.lightBlack, for: .normal)
                self.setupViews()
            } else {
                self.buildButton.backgroundColor = .white
                self.buildButton.setTitleColor(AppColor.lightBlack, for: .normal)
                self.quitButton.backgroundColor = AppColor.lightBlack
                self.quitButton.setTitleColor(.white, for: .normal)
                self.removeGoalView()
            }
        }
    }
    
    
    func removeGoalView() {
        overrallStackView.removeFully(view: setGoalLabel)
        overrallStackView.removeFully(view: goalStackView)
    }
    
    
    func setupHeaders() {
        title = viewModel.habit.name
        tabBarItem?.title = ""
        view.backgroundColor = .white
    }
    
    
    func customizeUIControlls() {
        nameTextField.smartInsertDeleteType = .no
        nameTextField.delegate = self
        nameTextField.tintColor = AppColor.lightAsh
        nameTextField.setRoundedBorder(borderColor: AppColor.lightAsh, borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        nameTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        buildButton.addTarget(self, action: #selector(buildButtonTapped), for: .touchUpInside)
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        
        numberOfDaysIncrementStepper.autorepeat = true
        numberOfDaysIncrementStepper.value = Double(viewModel.habit.daysValue)
        numberOfDaysIncrementStepper.minimumValue = 1
        numberOfDaysIncrementStepper.addTarget(self, action: #selector(handleDaysIncrement), for: .valueChanged)
        
        setGoalTextField.tintColor = AppColor.lightAsh
        setGoalTextField.setRoundedBorder(borderColor: AppColor.lightAsh, borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        setGoalTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        setGoalTextField.keyboardType = .numberPad
                
        updateButton.isEnabled = false
        updateButton.setRoundedBorder(borderColor: AppColor.lightAsh, borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        
        deleteButton.setRoundedBorder(borderColor: AppColor.pinkishRed, borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
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
        updateButton.setHeight(height)
        deleteButton.setHeight(height)

        let buttonSpacingView = UIView()
        buttonSpacingView.backgroundColor = .white
                
        let buttonStackView = UIStackView(arrangedSubviews: [buildButton, quitButton, buttonSpacingView])
        buttonStackView.spacing = spacing
        buttonStackView.alignment = .fill
        buttonStackView.setHeight(height)
        
        let initialDaysSpacingView = UIView()
        initialDaysSpacingView.backgroundColor = .white
        
        let initialDaysStackView = UIStackView(arrangedSubviews: [numberOfDaysValueLabel, initialDaysSpacingView, numberOfDaysIncrementStepper])
        initialDaysStackView.spacing = spacing
        initialDaysStackView.alignment = .fill
        
        let goalSpacingView = UIView()
        goalSpacingView.backgroundColor = .white
        
        goalStackView = UIStackView(arrangedSubviews: [setGoalTextField, timePerWeekLabel, goalSpacingView])
        goalStackView.spacing = spacing
        goalStackView.alignment = .fill
        
        overrallStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, typeLabel, buttonStackView, numberOfDaysLabel, initialDaysStackView, setGoalLabel, goalStackView, updateButton, deleteButton])
        overrallStackView.axis = .vertical
        overrallStackView.spacing = spacing
        
        contentView.addSubview(overrallStackView)
        overrallStackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 30, left: spacing, bottom: 0, right: spacing))
    }
    
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800)
        ])
    }
}


// MARK: - UITextFieldDelegate
extension HabitDetailsVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= GlobalConstants.charactorLimit
    }
}
