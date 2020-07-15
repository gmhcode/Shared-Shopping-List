//
//  Item.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import CoreData
class ItemController {
    
    static let shared = ItemController()

    static func createItem(name: String, store: String, userSent: User, list: List) -> Item {
        
        let persistentManager = PersistenceManager.shared
        let item = Item(context: persistentManager.context)
        
        item.name = name
        item.store = store
        item.userSentId = userSent.id
        item.listID = list.id
        item.id = UUID()
        
        persistentManager.saveContext()
        return item
    }
    
    ///Gets the List from the entered ID
    static func getItem(id: UUID) -> Item? {
        
        let persistentManager = PersistenceManager.shared
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let item = try persistentManager.context.fetch(request)
            if item.count > 0 {
                return item[0]
            } else {
                return nil
            }
        } catch  {
            print("array could not be retrieved \(error)")
            return nil
        }
    }
    
    ///Gets all lists
    static func getAllItem() -> [Item] {
        let persistentManager = PersistenceManager.shared
        let locations = persistentManager.fetch(Item.self)
        return locations
    }
    
    ///Deletes list with the entered ID
    static func deleteItem(id:UUID) {
        let persistentManager = PersistenceManager.shared
        let item = getItem(id: id)
        if item != nil {
            persistentManager.delete(item!)
        }
        persistentManager.saveContext()
    }
    static func deleteAllItems() {
        let persistentManager = PersistenceManager.shared
        let item = getAllItem()
        
        for i in item {
            persistentManager.delete(i)
        }
        persistentManager.saveContext()
    }
    
    ///Change the list's title
    static func changeName(id:UUID, newName: String) {
        guard let item = getItem(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        let persistentManager = PersistenceManager.shared
        item.name = newName
        persistentManager.saveContext()
    }
    
    ///Update the name and store of the Item of the entered ID
    static func updateItem(name: String, store: String, id: UUID) {
        let persistentManager = PersistenceManager.shared
        guard let item = getItem(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        
        item.name = name
        item.store = store
        
        persistentManager.saveContext()
    }

}
