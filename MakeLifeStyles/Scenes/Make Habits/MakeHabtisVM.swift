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
    
    func saveHabit(completion: @escaping (Bool, String) -> ()) {
        let habit = Habit(entity: Habit.entity(), insertInto: context)
        habit.id = UUID()
        habit.name = habitName ?? ""
        habit.category = "Category"
        habit.type = habitType
        habit.daysValue = numberOfDays ?? 1
        habit.initialDaysValue = numberOfDays ?? 1
        habit.repetitionsValue = Int(goal ?? "1") ?? 1
        habit.startDate = Date()
        habit.updatedAt = Date()
        
        do {
            try context.save()
            completion(true, Strings.habitSavedSuccessfully)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false, Strings.somethingWentWrong)
        }
    }
    
    
    private func checkFormValidity() {
        let isFormValid = habitName?.isEmpty == false && habitName?.count ?? 0 >= 3 && goal?.isEmpty == false
        bindalbeIsFormValid.value = isFormValid
    }
}
