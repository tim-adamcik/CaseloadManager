//
//  GoalData+CoreDataProperties.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/31/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//
//

import Foundation
import CoreData


extension GoalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalData> {
        return NSFetchRequest<GoalData>(entityName: "GoalData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var percentage: Double
    @NSManaged public var goal: Goal?

}
