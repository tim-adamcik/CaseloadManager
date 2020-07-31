//
//  AgeGroup+CoreDataProperties.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/31/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//
//

import Foundation
import CoreData


extension AgeGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AgeGroup> {
        return NSFetchRequest<AgeGroup>(entityName: "AgeGroup")
    }

    @NSManaged public var type: String?
    @NSManaged public var students: NSSet?
    @NSManaged public var studentGroups: NSSet?

}

// MARK: Generated accessors for students
extension AgeGroup {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Student)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Student)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}

// MARK: Generated accessors for studentGroups
extension AgeGroup {

    @objc(addStudentGroupsObject:)
    @NSManaged public func addToStudentGroups(_ value: StudentGroup)

    @objc(removeStudentGroupsObject:)
    @NSManaged public func removeFromStudentGroups(_ value: StudentGroup)

    @objc(addStudentGroups:)
    @NSManaged public func addToStudentGroups(_ values: NSSet)

    @objc(removeStudentGroups:)
    @NSManaged public func removeFromStudentGroups(_ values: NSSet)

}
