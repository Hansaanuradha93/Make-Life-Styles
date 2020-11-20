import UIKit

class MakeHabitsVM {
    
    // MARK: Properties
    var habitName: String? { didSet { checkFormValidity() } }
    var isBuildHabit: Bool? = true
    var numberOfDays: Int? = 1
    var goal: String? = "1" { didSet { checkFormValidity() } }
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: Bindlable
    var bindalbeIsFormValid = Bindable<Bool>()
}


// MARK: - Methods
extension MakeHabitsVM {
    
    func saveHabit() {
        let habit = Habit(entity: Habit.entity(), insertInto: context)
        habit.id = 1
        habit.name = "Test Habit"
        habit.category = "Category"
        habit.type = "Build"
        habit.days = 1
        habit.initialDays = 1
        habit.repetitions = 10
        habit.startDate = Date()
        
        appDelegate.saveContext()
    }
    
    
    func checkFormValidity() {
        let isFormValid = habitName?.isEmpty == false && habitName?.count ?? 0 >= 4 && goal?.isEmpty == false
        bindalbeIsFormValid.value = isFormValid
    }
}
