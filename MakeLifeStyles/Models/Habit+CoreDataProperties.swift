import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var category: String?
    @NSManaged public var days: Int16
    @NSManaged public var initialDays: Int16
    @NSManaged public var name: String?
    @NSManaged public var repetitions: Int16
    @NSManaged public var startDate: Date?
    @NSManaged public var type: String?

}

extension Habit : Identifiable {

}
