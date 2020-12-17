import UIKit
import CoreData

class LifeStylesVM {
    
    // MARK: Properties
    var habits = [Habit]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}


// MARK: - Private Methods
extension LifeStylesVM {
    
    func delete(habit: Habit, completion: @escaping (Bool, String) -> ()) {
        context.delete(habit)
        
        do {
            try context.save()
            completion(true, Strings.habitDeletedSuccessfully)
        } catch let error as NSError {
            print(error.localizedDescription)
            completion(false,Strings.somethingWentWrong)
        }
    }
    
    
    func updateHabit() {
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchHabits(completion: @escaping (Bool) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Habit")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "days >= %@", "\(GlobalConstants.lifeStyleDays)")
        
        do {
            let habits = try context.fetch(fetchRequest)
            self.habits = habits as! [Habit]
            completion(true)
        } catch let error as NSError {
            print("Could not fetch data. \(error), \(error.userInfo)")
            completion(false)
        }
    }
}
