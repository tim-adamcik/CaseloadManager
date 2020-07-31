//
//  Goal+CoreDataProperties.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/31/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var goal: String?
    @NSManaged public var student: Student?
    @NSManaged public var goalData: NSSet?

}

// MARK: Generated accessors for goalData
extension Goal {

    @objc(addGoalDataObject:)
    @NSManaged public func addToGoalData(_ value: GoalData)

    @objc(removeGoalDataObject:)
    @NSManaged public func removeFromGoalData(_ value: GoalData)

    @objc(addGoalData:)
    @NSManaged public func addToGoalData(_ values: NSSet)

    @objc(removeGoalData:)
    @NSManaged public func removeFromGoalData(_ values: NSSet)

}
