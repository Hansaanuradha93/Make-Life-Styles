//
//  Habit+CoreDataProperties.swift
//  MakeLifeStyles
//
//  Created by Hansa Anuradha on 2020-11-20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var initialDays: Int16
    @NSManaged public var name: String?
    @NSManaged public var repetitions: Int16
    @NSManaged public var startDate: Date?
    @NSManaged public var type: String?
    @NSManaged public var id: Int32
    @NSManaged public var category: String?
    @NSManaged public var days: Int16

}

extension Habit : Identifiable {

}
