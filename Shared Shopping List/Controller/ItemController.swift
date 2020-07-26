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
        item.userSentId = userSent.uuid
        item.listID = list.uuid
        item.uuid = UUID().uuidString
        
        persistentManager.saveContext()
        return item
    }
    
    ///Gets the List from the entered ID
    static func getItem(id: String) -> Item? {
        
        let persistentManager = PersistenceManager.shared
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
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
    static func deleteItem(id:String) {
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
    static func changeName(id:String, newName: String) {
        guard let item = getItem(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        let persistentManager = PersistenceManager.shared
        item.name = newName
        persistentManager.saveContext()
    }
    
    ///Update the name and store of the Item of the entered ID
    static func updateItem(name: String, store: String, id: String) {
        let persistentManager = PersistenceManager.shared
        guard let item = getItem(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        
        item.name = name
        item.store = store
        
        persistentManager.saveContext()
    }
    
    
    struct BackEnd {
        var url = URL(string: "http://localhost:8081/")
        static var shared = ItemController.BackEnd()
        
        func callItems(completion: @escaping ([CodableItem]) -> () ) {
            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion([]); return}
            url.appendPathComponent(BackEndUtils.PathComponent.items.rawValue)
            
            let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.get.rawValue, body: nil)
            
            URLSession.shared.dataTask(with: request) { (data, res, error) in
                if let error = error {
                    print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line)")
                    return
                }
                
                guard let data = data else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion([]); return }
                do {
                    let jsonDecoder = JSONDecoder()
                    let items = try jsonDecoder.decode([CodableItem].self, from: data)
                    print("items", items)
                    completion(items)
                }catch let er{
                    
                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                }
            }.resume()
        }
    }
}
