import UIKit

class HabitDetailsVM {
    
    // MARK: Prperties
    let habit: Habit
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
    
    
    // MARK: Initializers
    init(habit: Habit) {
        self.habit = habit
    }
}


// MARK: - Private Methods
extension HabitDetailsVM {
    
    func updateHabit() {
        do {
            habit.name = habitName
            habit.type = habitType
            habit.daysValue = numberOfDays ?? habit.daysValue
            habit.repetitionsValue = Int(goal ?? "") ?? habit.repetitionsValue
            
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    private func checkFormValidity() {
        let isFormValid = habitName?.isEmpty == false && habitName?.count ?? 0 >= 3 && goal?.isEmpty == false
        bindalbeIsFormValid.value = isFormValid
    }
}
