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
    
    static func createGroup(name: String, id: String, password: String, masterUser: User, lists: [List]) -> Group {
        let group = Group(name: name, id: id, password: password, masterUser: masterUser, lists: lists)
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
