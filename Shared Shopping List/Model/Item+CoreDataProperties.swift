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

    @NSManaged public var listID: String
    @NSManaged public var store: String
    @NSManaged public var userSentId: String
    @NSManaged public var name: String
    @NSManaged public var uuid: String

}

class CodableItem : Codable, Identifiable {
    internal init(listID: String, store: String, userSentId: String, name: String, uuid: String) {
        self.listID = listID
        self.store = store
        self.userSentId = userSentId
        self.name = name
        self.uuid = uuid
    }
    
    let listID : String
    let store : String
    let userSentId : String
    let name : String
    let uuid : String
}
