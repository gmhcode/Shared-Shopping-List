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
    var list : List?
    static let shared = ListController()
    
    @discardableResult static func createList(title: String, listMaster: User, uuid: String ) -> List {
        
        let persistentManager = PersistenceManager.shared
        let list = List(context: persistentManager.context)
        
        list.uuid = uuid
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
    
    struct BackEnd {
        var url = URL(string: "http://localhost:8081/")
        static var shared = ListController.BackEnd()
        
        func createList(list: List) {
            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            url.appendPathComponent(BackEndUtils.PathComponent.list.rawValue)
            
            let params : [String:Any] = getParams(list: list)
            
            
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: params, options: .init())
                let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.post.rawValue, body: requestBody)
                
                URLSession.shared.dataTask(with: request) { (data, res, er) in
                    if let er = er {
                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                        return
                    }
                    
                    if let response = res, let data = data  {
                        print("Create List Response", response, BackEndUtils.convertDataToJson(data: data))
                    }
                    
                }.resume()
                
            } catch let err {
                print("❌ There was an error in \(#function) \(err) : \(err.localizedDescription) : \(#file) \(#line)")
            }
        }
        
        func updateList(list: List) {
            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            url.appendPathComponent(BackEndUtils.PathComponent.list.rawValue)
            
            let params : [String:Any] = getParams(list: list)
            
            
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: params, options: .init())
                let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.update.rawValue, body: requestBody)
                URLSession.shared.dataTask(with: request) { (data, res, er) in
                    if let er = er {
                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                        return
                    }
                    
                    if let response = res, let data = data  {
                        print("Create User Response", response, BackEndUtils.convertDataToJson(data: data))
                    }
                    
                }.resume()
                
            } catch let err {
                print("❌ There was an error in \(#function) \(err) : \(err.localizedDescription) : \(#file) \(#line)")
            }
        }
        
        func deleteAllLists() {
            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            url.appendPathComponent(BackEndUtils.PathComponent.lists.rawValue)
            
            let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.delete.rawValue, body: nil)
            URLSession.shared.dataTask(with: request) { (data, res, er) in
                if let er = er {
                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                    return
                }
                
                if let response = res, let data = data  {
                    print("Delete All Lists Response", response, BackEndUtils.convertDataToJson(data: data))
                }
                
            }.resume()
        }
        
        func getAllLists(completion: @escaping([CodableList])->()) {
            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion([]); return}
            url.appendPathComponent(BackEndUtils.PathComponent.lists.rawValue)
            
            let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.get.rawValue, body: nil)
            URLSession.shared.dataTask(with: request) { (data, res, er) in
                if let er = er {
                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                    completion([])
                    return
                }
                
                if let data = data  {
                    do {
                        let lists = try JSONDecoder().decode([CodableList].self, from: data)
                        completion(lists)
                    } catch let error {
                        print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                    }
                } else {
                    completion([])
                }
                
            }.resume()
            
        }
        func getParams(list: List) -> [String:Any] {
            let params : [String:Any] = ["uuid":list.uuid,"title":list.title,"listMasterID":list.listMasterID]
            return params
        }
        
        
    }
    
}
