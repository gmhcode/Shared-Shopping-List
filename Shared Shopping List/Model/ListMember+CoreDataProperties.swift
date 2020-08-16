//
//  ListMember+CoreDataProperties.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/13/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//
//

import Foundation
import CoreData


extension ListMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListMember> {
        return NSFetchRequest<ListMember>(entityName: "ListMember")
    }

    @NSManaged public var listID: String
    @NSManaged public var userID: String
    @NSManaged public var uuid: String

}
