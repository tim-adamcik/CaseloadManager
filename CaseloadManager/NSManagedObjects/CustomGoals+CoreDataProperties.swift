//
//  CustomGoals+CoreDataProperties.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/31/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//
//

import Foundation
import CoreData


extension CustomGoals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomGoals> {
        return NSFetchRequest<CustomGoals>(entityName: "CustomGoals")
    }

    @NSManaged public var customGoal: String?

}
