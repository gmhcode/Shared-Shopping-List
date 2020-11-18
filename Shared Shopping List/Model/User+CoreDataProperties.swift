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
    @NSManaged public var uuid: String
    @NSManaged public var email: String
    
}

class CodableUser : Codable {
    internal init(uuid: String, name: String, email: String) {
        self.uuid = uuid
        self.name = name
        self.email = email
    }
    
    let uuid : String
    let name : String
    let email : String
}
