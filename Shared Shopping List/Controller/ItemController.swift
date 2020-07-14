//
//  Item.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
class ItemController {
    static let shared = ItemController()
//    var items = [String:Item]()
    static func createItem(name: String, store: String, userSent: User, list: List) -> Item {
        
        let persistentManager = PersistenceManager.shared
        let item = Item(context: persistentManager.context)
        
        item.name = name
        item.store = store
        item.userSentId = userSent.id
        item.listID = list.id
        
        persistentManager.saveContext()
        return item
    }
    
    func readItem() {
        
    }
    
//    func updateItem() -> Item {
//
//    }
    
    func deleteItem() {
        
    }
}
