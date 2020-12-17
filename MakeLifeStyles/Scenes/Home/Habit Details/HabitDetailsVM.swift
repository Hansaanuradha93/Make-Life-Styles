import UIKit

class HabitDetailsVM {
    
    // MARK: Prperties
    let habit: Habit
    var isUpdating: Bool? { didSet { checkFormValidity() } }
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
    
    var numberOfDaysString: String {
        if habit.daysValue == 1 {
            return Strings.oneDay
        } else if habit.daysValue > 1 {
            return "\(habit.daysValue) \(Strings.days)"
        }
        return ""
    }
    
    
    // MARK: Initializers
    init(habit: Habit) {
        self.habit = habit
    }
}


// MARK: - Private Methods
extension HabitDetailsVM {
    
    func deleteHabit(completion: @escaping (Bool, String) -> ()) {
        context.delete(habit)
        
        do {
            try context.save()
            completion(true, Strings.habitDeletedSuccessfully)
        } catch let error as NSError {
            print(error.localizedDescription)
            completion(false,Strings.somethingWentWrong)
        }
    }
    
    func updateHabit(completion: @escaping (Bool, String, String, Int?) -> ()) {
        do {
            habit.name = habitName
            habit.type = habitType
            habit.daysValue = numberOfDays ?? habit.daysValue
            habit.repetitionsValue = Int(goal ?? "") ?? habit.repetitionsValue
            habit.updatedAt = Date()
            
            try context.save()
            if habit.days < GlobalConstants.lifeStyleDays {
                completion(true, Strings.successful, Strings.habitUpdatedSuccessfully, nil)
            } else {
                completion(true, Strings.congradulations, Strings.youHaveNewLifeStyleNow, 2)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            completion(false, Strings.failed ,Strings.somethingWentWrong, nil)
        }
    }
    
    
    private func checkFormValidity() {
        let isFormValid = (isUpdating ?? false) && habitName?.isEmpty == false && habitName?.count ?? 0 >= 3 && goal?.isEmpty == false
        bindalbeIsFormValid.value = isFormValid
    }
}
