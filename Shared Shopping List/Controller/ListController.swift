//
//  ListController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
class ListController {
    
    static let shared = ListController()
    var lists = [String:List]()
    
    static func createList(title: String, listMaster: User, groupID: String, items: [Item]) -> List {
        let persistentManager = PersistenceManager.shared
        let list = List(context: persistentManager.context)
        
//        let list = List(title: title, listMaster: listMaster, groupID: groupID, items: items)
        return list
    }
//    
//    func readList() {
//        
//    }
//    
//    func updateList() -> List {
//        
//    }
//    
//    func deleteList() {
//        
//    }
    
}
