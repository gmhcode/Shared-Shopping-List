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


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }
    @NSManaged public var uuid: String
    @NSManaged public var title: String
    @NSManaged public var listMasterID: String

}

class CodableList : Codable {
    let uuid : String
    let title : String
    let listMasterID : String
}
