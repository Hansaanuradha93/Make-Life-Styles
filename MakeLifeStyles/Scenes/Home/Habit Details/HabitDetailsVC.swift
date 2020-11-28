import UIKit

class HabitDetailsVC: UIViewController {
    
    // MARK: Perperties
    var viewModel: HabitDetailsVM!
    
    
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
        print(viewModel.habit)
    }
}
