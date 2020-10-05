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
    
    static func createItem(name: String, store: String, userSentID: String, listID: String, uuid: String) -> Item {
        
        if let i = getItem(id: uuid){
            return i
        }
        
        let persistentManager = PersistenceManager.shared
        let item = Item(context: persistentManager.context)
        
        item.name = name
        item.store = store
        item.userSentId = userSentID
        item.listID = listID
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
    
    static func getItems(for list:List) -> [Item]? {
        let persistentManager = PersistenceManager.shared
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "listID == %@", list.uuid as CVarArg)
        request.predicate = predicate
        
        do {
            let items = try persistentManager.context.fetch(request)
            if items.count > 0 {
                return items
            } else {
                return nil
            }
        } catch  {
            print("array could not be retrieved \(error)")
            return nil
        }
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
        //        var url = BackEndUtils.currentServerUrl
        static var shared = ItemController.BackEnd()
        
        func createItemFrontAndBack(name: String, store: String, userSentID: String, listID: String, uuid: String, completion: @escaping(Item)->()) {
            let item = ItemController.createItem(name: name, store: store, userSentID: userSentID, listID: listID, uuid: uuid)
            createItem(item: item) {_ in 
                completion(item)
            }
            
        }
        func parseFetchedItems(items: [[String:Any]]) -> [Item]? {
            guard !items.isEmpty else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return nil}
            var returningItems : [Item] = []
            
            for i in items {
                guard let uuid = i["uuid"] as? String,
                      let store = i["store"] as? String,
                      let name = i["name"] as? String,
                      let userSent = i["userSentId"] as? String,
                      let listID = i["listID"] as? String else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); continue}
                
                let fetchedItem = ItemController.createItem(name: name, store: store, userSentID: userSent, listID: listID, uuid: uuid)
                
                returningItems.append(fetchedItem)
                
            }
            
            if returningItems.isEmpty {
                return nil
            }
            return returningItems
        }
        
        func getParams(item: Item?) -> [String:Any] {
            guard let item = item else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return [:]}
            
            let params : [String:Any] = ["listID":item.listID,"store":item.store,"userSentId":item.userSentId,"name":item.name,"uuid":item.uuid]
            return params
        }
        
        func createItem(item: Item, completion:@escaping(Item?)->()) {
            
            networkCall(objectToSend: item, queryItems: [], pathComponents: [BackEndUtils.PathComponent.item.rawValue], requestMethod: .post) { (items) in
                guard let item = items?.first else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<");completion(nil); return}
                
                print("createList: ", items as Any)
                completion(item)
            }
            
            //            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<");completion(); return}
            //            url.appendPathComponent(BackEndUtils.PathComponent.item.rawValue)
            //
            //            let params : [String:Any] = getParams(item: item)
            //
            //
            //            do {
            //                let requestBody = try JSONSerialization.data(withJSONObject: params, options: .init())
            //                let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.post.rawValue, body: requestBody)
            //
            //                URLSession.shared.dataTask(with: request) { (data, res, er) in
            //                    if let er = er {
            //                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
            //                        completion()
            //                        return
            //                    }
            //
            //                    if let response = res, let data = data  {
            //                        print("Create List Response", response, BackEndUtils.convertDataToJson(data: data))
            //                        completion()
            //                    }
            //
            //                }.resume()
            //
            //            } catch let err {
            //                print("❌ There was an error in \(#function) \(err) : \(err.localizedDescription) : \(#file) \(#line)")
            //                completion()
            //            }
        }
        
        func getItemsWithUser(user: User, completion:@escaping([Item]?)->()) {
            let userIDQuery = URLQueryItem(name: "userID", value: user.uuid)
            let emptyValue = URLQueryItem(name: "listID", value: "")
            
            networkCall(objectToSend: nil, queryItems: [userIDQuery,emptyValue], pathComponents: [BackEndUtils.PathComponent.items.rawValue,BackEndUtils.PathComponent.query.rawValue], requestMethod: .get) { (items) in
                completion(items)
            }
            
        }
        func getItemsWithList(list: List, completion:@escaping([Item]?)->()) {
            let emptyValue = URLQueryItem(name: "userID", value: "")
            let listIDQuery = URLQueryItem(name: "listID", value: list.uuid)
            
            networkCall(objectToSend: nil, queryItems: [emptyValue,listIDQuery], pathComponents: [BackEndUtils.PathComponent.items.rawValue,BackEndUtils.PathComponent.query.rawValue], requestMethod: .get) { (items) in
                completion(items)
            }
        }
        
        func callAllItems(completion: @escaping ([Item]?) -> () ) {
            
            networkCall(objectToSend: nil, queryItems: [], pathComponents: [BackEndUtils.PathComponent.items.rawValue], requestMethod: .get) { (items) in
                completion(items)
            }
            
            
            //            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion([]); return}
            //            url.appendPathComponent(BackEndUtils.PathComponent.items.rawValue)
            //
            //            let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.get.rawValue, body: nil)
            //
            //            URLSession.shared.dataTask(with: request) { (data, res, error) in
            //                if let error = error {
            //                    print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line)")
            //                    return
            //                }
            //
            //                guard let data = data else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion([]); return }
            //                do {
            //                    if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String:Any]] {
            //                        if let items = self.parseFetchedItems(items: json) {
            //                            print("🇸🇾 Items JSON",json)
            //                            completion(items)
            //                            return
            //                        }
            //                    }
            //                }catch let er {
            //
            //                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
            //                }
            //                completion(nil)
            //            }.resume()
        }
    }
}
extension ItemController.BackEnd : BackEndRequester {
    var url: URL {
        return BackEndUtils.currentServerUrl!
    }
    
    var getParameters: (Item?) -> [String : Any] {
        return getParams
    }
    
    var parseFetched: ([[String : Any]]) -> [Item]? {
        return parseFetchedItems
    }
    
    typealias MyType = Item
    
    
}
