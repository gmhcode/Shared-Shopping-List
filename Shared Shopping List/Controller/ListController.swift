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
    
    static func createList(title: String, listMaster: User, group: Group, items: [Item]) -> List {
        let list = List(title: title, listMaster: listMaster, group: group, items: items)
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
