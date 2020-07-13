//
//  Group+CoreDataProperties.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/13/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var password: String
    @NSManaged public var masterUserID: UUID

}
