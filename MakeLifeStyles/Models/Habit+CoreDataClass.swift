import Foundation
import CoreData

public class Habit: NSManagedObject {

    var initialDaysValue : Int {
        get { return Int(initialDays) }
        set { initialDays = Int16(newValue) }
    }
    
    var daysValue : Int {
        get { return Int(days) }
        set { days = Int16(newValue) }
    }
    
    var repetitionsValue : Int {
        get { return Int(repetitions) }
        set { repetitions = Int16(newValue) }
    }
    
    var habitType: Bool {
        get { return ((type == "Build") ? true : false) }
    }
}
