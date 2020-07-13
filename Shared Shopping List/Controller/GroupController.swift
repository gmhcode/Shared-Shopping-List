//
//  GroupController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
class GroupController {
    static let shared = GroupController()
    
    static func createGroup(name: String, id: String, password: String, masterUser: User) -> Group {
        let persistentManager = PersistenceManager.shared
        let group = Group(context: persistentManager.context)
        group.id = UUID()
        group.masterUserID = masterUser.id
        group.name = name
        group.password = password
        return group
    }
//    
//    func readGroup() {
//        
//    }
//    
//    func updateGroup() -> Group {
//        
//    }
//    
//    func deleteGroup() {
//        
//    }
}
