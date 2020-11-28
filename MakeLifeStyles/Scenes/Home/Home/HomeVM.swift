import UIKit
import CoreData

final class HomeVM {
    
    // MARK: Properties
    var habits = [Habit]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}


// MARK: Public Methods
extension HomeVM {
    
    func update(_ habit: Habit) {
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchHabits(completion: @escaping (Bool) -> ()) {
        do {
            let habits = try context.fetch(Habit.fetchRequest())
            self.habits = habits as! [Habit]
            completion(true)
        } catch let error as NSError {
            print("Could not fetch data. \(error), \(error.userInfo)")
            completion(false)
        }
    }
}
