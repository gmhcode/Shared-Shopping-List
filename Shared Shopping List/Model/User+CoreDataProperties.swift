//
//  User+CoreDataProperties.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/9/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var email: String
    
}
