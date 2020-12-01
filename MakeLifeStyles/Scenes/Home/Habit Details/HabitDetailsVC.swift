import UIKit
import CoreData

class HabitDetailsVC: UIViewController {

    // MARK: Perperties
    private var viewModel: HabitDetailsVM!
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let nameLabel = LSBodyLabel(text: "Habit", textColor: .white, fontSize: 20, textAlignment: .left)
    private let nameTextField = LSTextField(backgroundColor: UIColor.appColor(color: .darkestAsh), textColor: UIColor.appColor(color: .lightAsh), textSize: 20, padding: 16)
    
    private let typeLabel = LSBodyLabel(text: "Habit Type", textColor: .white, fontSize: 20, textAlignment: .left)
    private let buildButton = LSButton(backgroundColor: UIColor.appColor(color: .lightBlack), title: Strings.build, titleColor: UIColor.appColor(color: .lightAsh), radius: GlobalDimensions.cornerRadius, fontSize: 14)
    private let quitButton = LSButton(backgroundColor: UIColor.appColor(color: .darkestAsh), title: Strings.quit, titleColor: UIColor.appColor(color: .lightAsh), radius: GlobalDimensions.cornerRadius, fontSize: 14)
    
    private let numberOfDaysLabel = LSBodyLabel(text: "Number of Days", textColor: .white, fontSize: 20, textAlignment: .left, numberOfLines: 0)
    private let numberOfDaysValueLabel = LSBodyLabel(text: Strings.oneDay, textColor: UIColor.appColor(color: .lightAsh), fontSize: 18, textAlignment: .left, numberOfLines: 0)
    private let numberOfDaysIncrementStepper = UIStepper (frame:CGRect(x: 10, y: 150, width: 0, height: 0))
    
    private let setGoalLabel = LSBodyLabel(text: "Goal", textColor: .white, fontSize: 20, textAlignment: .left)
    private let setGoalTextField = LSTextField(text: Strings.one, backgroundColor: UIColor.appColor(color: .darkestAsh), textColor: UIColor.appColor(color: .lightAsh), textSize: 20, padding: 16)
    private let timePerWeekLabel = LSBodyLabel(text: Strings.moreTimesPerDay, textColor: UIColor.appColor(color: .lightAsh), fontSize: 18, textAlignment: .left)
    
    private let updateButton = LSButton(backgroundColor: UIColor.appColor(color: .darkestAsh), title: "Update", titleColor: UIColor.appColor(color: .lightAsh), radius: GlobalDimensions.cornerRadius)

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.appColor(color: .darkestAsh)
        return view
    }()
    
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
    
    @objc func saveButtonTapped() {
//        viewModel.saveHabit { [weak self] status, message in
//            guard let self = self else { return }
//            if status {
//                self.presentLSAlertOnMainTread(title: Strings.successful, message: message, buttonTitle: Strings.ok)
//            } else {
//                self.presentLSAlertOnMainTread(title: Strings.failed, message: message, buttonTitle: Strings.ok)
//            }
//        }
//        resetUI()
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
private extension HabitDetailsVC {
    
    func setData() {
        let habit = viewModel.habit
        
        nameTextField.text = habit.name
        changeButtons(isBuildClicked: habit.habitType)
        setGoalTextField.text = "\(habit.repetitionsValue)"
        if habit.daysValue == 1 {
            numberOfDaysValueLabel.text = Strings.oneDay
        } else if habit.daysValue > 1 {
            numberOfDaysValueLabel.text = "\(habit.daysValue) \(Strings.days)"
        }
    }
    
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
                self.updateButton.backgroundColor = UIColor.appColor(color: .lightBlack)
                self.updateButton.setTitleColor(.white, for: .normal)
                self.updateButton.setRoundedBorder(radius: 25)
            } else {
                self.updateButton.backgroundColor = UIColor.appColor(color: .darkestAsh)
                self.updateButton.setTitleColor(UIColor.appColor(color: .lightAsh), for: .normal)
                self.updateButton.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: 25)
            }
            self.updateButton.isEnabled = isFormValid
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
        view.backgroundColor = UIColor.appColor(color: .darkestAsh)
        
        let attributesForLargeTitle = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributesForLargeTitle
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    func customizeUIControlls() {
        nameTextField.tintColor = UIColor.appColor(color: .lightAsh)
        nameTextField.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: 0.5, radius: GlobalDimensions.cornerRadius)
        nameTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        buildButton.addTarget(self, action: #selector(buildButtonTapped), for: .touchUpInside)
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        
        numberOfDaysIncrementStepper.autorepeat = true
        numberOfDaysIncrementStepper.value = Double(viewModel.habit.daysValue)
        numberOfDaysIncrementStepper.minimumValue = 1
        numberOfDaysIncrementStepper.addTarget(self, action: #selector(handleDaysIncrement), for: .valueChanged)
        
        setGoalTextField.tintColor = UIColor.appColor(color: .lightAsh)
        setGoalTextField.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        setGoalTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        setGoalTextField.keyboardType = .numberPad
                
        updateButton.isEnabled = false
        updateButton.setRoundedBorder(borderColor: UIColor.appColor(color: .lightAsh), borderWidth: GlobalDimensions.borderWidth, radius: GlobalDimensions.cornerRadius)
        updateButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
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
        
        overrallStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, typeLabel, buttonStackView, numberOfDaysLabel, initialDaysStackView, setGoalLabel, goalStackView, updateButton])
        overrallStackView.axis = .vertical
        overrallStackView.spacing = spacing
        
        contentView.addSubview(overrallStackView)
        overrallStackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 30, left: spacing, bottom: 0, right: spacing))
    }
    
    
    func setupScrollView() {
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
