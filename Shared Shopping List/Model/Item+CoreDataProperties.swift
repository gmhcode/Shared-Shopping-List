//
//  Item+CoreDataProperties.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/13/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var listID: UUID
    @NSManaged public var store: String
    @NSManaged public var userSentId: UUID
    @NSManaged public var name: String
    @NSManaged public var id: UUID

}
