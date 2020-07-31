//
//  StudentGroup+CoreDataProperties.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/31/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//
//

import Foundation
import CoreData


extension StudentGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentGroup> {
        return NSFetchRequest<StudentGroup>(entityName: "StudentGroup")
    }

    @NSManaged public var name: String?
    @NSManaged public var day: Date?
    @NSManaged public var sessionLength: String?
    @NSManaged public var ageGroup: AgeGroup?
    @NSManaged public var students: NSSet?

}

// MARK: Generated accessors for students
extension StudentGroup {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Student)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Student)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}
