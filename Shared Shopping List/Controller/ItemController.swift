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
        let item = Item(name: name, store: store, userSent: userSent, list: list)
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
