//
//  ListMember+CoreDataClass.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/13/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//
//

import Foundation
import CoreData


public class ListMember: NSManagedObject {

}
class CodableListMember: Codable, Identifiable {
    internal init(listID: String, userID: String, uuid: String, userName: String) {
        self.listID = listID
        self.userID = userID
        self.uuid = uuid
        self.userName = userName
    }
    
    var listID: String
    var userID: String
    var uuid: String
    var userName: String
}
