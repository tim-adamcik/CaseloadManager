//
//  Student+CoreDataProperties.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/31/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var studentID: String?
    @NSManaged public var age: Int16
    @NSManaged public var grade: String?
    @NSManaged public var caseManager: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var disorder: String?
    @NSManaged public var ageGroup: AgeGroup?
    @NSManaged public var goals: NSSet?
    @NSManaged public var studentGroup: StudentGroup?

}

// MARK: Generated accessors for goals
extension Student {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: Goal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: Goal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}
