//
//  List+CoreDataProperties.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/13/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//
//

import Foundation
import CoreData


extension SList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SList> {
        return NSFetchRequest<SList>(entityName: "SList")
    }
    @NSManaged public var uuid: String
    @NSManaged public var title: String
    @NSManaged public var listMasterID: String

}

class CodableList : Codable, Identifiable {
    internal init(uuid: String, title: String, listMasterID: String) {
        self.uuid = uuid
        self.title = title
        self.listMasterID = listMasterID
    }
    
    let uuid : String
    let title : String
    let listMasterID : String
}
