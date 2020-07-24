//
//  ListController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import CoreData


class ListController {
    
    static let shared = ListController()
    
    @discardableResult static func createList(title: String, listMaster: User) -> List {
        
        let persistentManager = PersistenceManager.shared
        let list = List(context: persistentManager.context)
        
        list.uuid = UUID().uuidString
        list.listMasterID = listMaster.uuid
        list.title = title
        persistentManager.saveContext()
        return list
    }
    
    ///Gets the List from the entered ID
    static func getList(id: String) -> List? {
        
        let persistentManager = PersistenceManager.shared
        let request : NSFetchRequest<List> = List.fetchRequest()
        let predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let list = try persistentManager.context.fetch(request)
            if list.count > 0 {
                return list[0]
            } else {
                return nil
            }
        } catch  {
            print("array could not be retrieved \(error)")
            return nil
        }
    }
    
    ///Gets all lists
    static func getAllLists() -> [List] {
        let persistentManager = PersistenceManager.shared
        let locations = persistentManager.fetch(List.self)
        return locations
    }
    
    ///Deletes list with the entered ID
    static func deleteList(id:String) {
        let persistentManager = PersistenceManager.shared
        let list = getList(id: id)
        if list != nil {
            persistentManager.delete(list!)
        }
        persistentManager.saveContext()
    }
    static func deleteAllLists() {
        let persistentManager = PersistenceManager.shared
        let lists = getAllLists()
        
        for i in lists {
            persistentManager.delete(i)
        }
        persistentManager.saveContext()
    }
    ///Change the list's title
    static func changeName(id:String, newTitle: String) {
        guard let list = getList(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        let persistentManager = PersistenceManager.shared
        list.title = newTitle
        persistentManager.saveContext()
    }
    
    static func changeListOwner(listID: String, newOwner: User) {
        let persistentManager = PersistenceManager.shared
        let list = getList(id: listID)
        list?.listMasterID = newOwner.uuid
        persistentManager.saveContext()
    }
    
}
