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
    
    
    // MARK: Computed Properties
    var habitType: String {
        return (isBuildHabit ?? true) ? "Build" : "Quit"
    }
}


// MARK: - Methods
extension MakeHabitsVM {
    
    func saveHabit() {
        let habit = Habit(entity: Habit.entity(), insertInto: context)
        habit.id = UUID()
        habit.name = habitName ?? ""
        habit.category = "Category"
        habit.type = habitType
        habit.daysValue = numberOfDays ?? 1
        habit.initialDaysValue = numberOfDays ?? 1
        habit.repetitionsValue = Int(goal ?? "1") ?? 1
        habit.startDate = Date()
        
        appDelegate.saveContext()
    }
    
    
    func checkFormValidity() {
        let isFormValid = habitName?.isEmpty == false && habitName?.count ?? 0 >= 4 && goal?.isEmpty == false
        bindalbeIsFormValid.value = isFormValid
    }
}
