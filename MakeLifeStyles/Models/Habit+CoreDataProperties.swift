import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var category: String?
    @NSManaged public var days: Int64
    @NSManaged public var initialDays: Int64
    @NSManaged public var name: String?
    @NSManaged public var repetitions: Int64
    @NSManaged public var startDate: Date?
    @NSManaged public var type: String?
    @NSManaged public var id: UUID?

}

extension Habit : Identifiable {

}
