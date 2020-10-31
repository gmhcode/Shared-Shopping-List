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
    var list : SList?
    static let shared = ListController()
    
    @discardableResult static func createList(title: String, listMasterID: String, uuid: String) -> SList {
        
        if let list = getList(id: uuid) {
            return list
        }
        
        let persistentManager = PersistenceManager.shared
        let list = SList(context: persistentManager.context)
        
        list.uuid = uuid
        list.listMasterID = listMasterID
        list.title = title
        ListMemberController.createListMember(listID: list.uuid, userID: list.listMasterID, uuid: nil)
        persistentManager.saveContext()
        return list
    }
    
    ///FrondEnd And BackEnd
    static func addMemberToListFrontAndBack(list: SList, newMember: User,completion:@escaping ()->()){
        
        
        if ListMemberController.getListMember(id: newMember.uuid+list.uuid) != nil {
            return
        }
        
        let persistentManager = PersistenceManager.shared

        let listMember = ListMemberController.createListMember(listID: list.uuid, userID: newMember.uuid, uuid: nil)
        ListMemberController.BackEnd.shared.addListMember(listMember: listMember) { (lm) in
            guard lm != nil else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion();return}
            completion()

        }
        persistentManager.saveContext()
    }
    
    
    ///Gets the List from the entered ID
    static func getList(id: String) -> SList? {
        
        let persistentManager = PersistenceManager.shared
        let request : NSFetchRequest<SList> = SList.fetchRequest()
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
    static func getAllLists() -> [SList] {
        let persistentManager = PersistenceManager.shared
        let locations = persistentManager.fetch(SList.self)
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
        var theurl = URL(string: "http://localhost:8081/")
        static var shared = ListController.BackEnd()
        
        func createList(list: SList, completion:@escaping(SList?)->()) {
            
            networkCall(objectToSend: list, queryItems: [], pathComponents: [BackEndUtils.PathComponent.list.rawValue], requestMethod: .post) { (lists) in
                guard let list = lists?.first else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<");completion(nil); return}

                print("createList: ", list as Any)
                completion(list)
            }
//           guard var url = theurl else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<");completion(nil); return}
//            url.appendPathComponent(BackEndUtils.PathComponent.list.rawValue)
//
//            let params : [String:Any] = getParams(list: list)
//
//
//            do {
//                let requestBody = try JSONSerialization.data(withJSONObject: params, options: .init())
//                let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.post.rawValue, body: requestBody)
//
//                URLSession.shared.dataTask(with: request) { (data, res, er) in
//                    if let er = er {
//                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
//                        completion(nil)
//                        return
//                    }
//
//                    if let response = res, let data = data  {
//                        print("Create List Response", response, BackEndUtils.convertDataToJson(data: data))
//                        completion(nil)
//                        return
//                    }
//
//                }.resume()
//
//            } catch let err {
//                print("❌ There was an error in \(#function) \(err) : \(err.localizedDescription) : \(#file) \(#line)")
//                
//            }
//            completion(nil)
        }

        func updateList(list: SList,completion:@escaping()->()) {
            
            
            networkCall(objectToSend: list, queryItems: [], pathComponents: [BackEndUtils.PathComponent.list.rawValue], requestMethod: .update) { (lists) in
                print("update ", lists as Any)
                completion()
            }
//            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
//            url.appendPathComponent(BackEndUtils.PathComponent.list.rawValue)
//
//            let params : [String:Any] = getParams(list: list)
//
//
//            do {
//                let requestBody = try JSONSerialization.data(withJSONObject: params, options: .init())
//                let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.update.rawValue, body: requestBody)
//                URLSession.shared.dataTask(with: request) { (data, res, er) in
//                    if let er = er {
//                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
//                        return
//                    }
//
//                    if let response = res, let data = data  {
//                        print("Create User Response", response, BackEndUtils.convertDataToJson(data: data))
//                    }
//
//                }.resume()
//
//            } catch let err {
//                print("❌ There was an error in \(#function) \(err) : \(err.localizedDescription) : \(#file) \(#line)")
//            }
        }

        func getListsWithUser(user: User, completion:@escaping (([SList]?) ->())) {
            
//            let query = URLQueryItem(name: "userID", value: user.uuid)
            
            networkCall(objectToSend: nil, queryItems: [], pathComponents: [BackEndUtils.PathComponent.lists.rawValue,user.uuid], requestMethod: .get) { (lists) in
                print(lists as Any)
                completion(lists)
                
            }
//            let preUrl = URL(string: "http://localhost:8081/lists/query")!
//
//            let query = URLQueryItem(name: "userID", value: user.uuid)
//
//            var components = URLComponents(url: preUrl, resolvingAgainstBaseURL: true)
//            components?.queryItems = [query]
//            guard let url = components?.url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<");completion(nil); return}
//
//            let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.get.rawValue, body: nil)
//
//            URLSession.shared.dataTask(with: request) { (data, res, error) in
//                if let error = error {
//                    print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line)")
//                    completion(nil)
//                    return
//                }
//                guard let data = data else {completion(nil); return}
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String:Any]] {
//                        if let lists = self.parseFetchedLists(lists: json) {
//                            completion(lists)
//                            return
//                        }
//                    }
//                }catch let er{
//                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
//                }
//              completion(nil)
//            }.resume()
//            completion(nil)
        }
        func deleteList(list:SList,completion:@escaping()->()) {
            networkCall(objectToSend: nil, queryItems: [], pathComponents: [BackEndUtils.PathComponent.list.rawValue,list.uuid], requestMethod: .delete) { (lists) in
                print(lists as Any)
                completion()
            }
        }

        func deleteAllLists() {
            networkCall(objectToSend: nil, queryItems: [], pathComponents: [BackEndUtils.PathComponent.lists.rawValue], requestMethod: .delete) { (lists) in
                print(lists as Any)
            }
//            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
//            url.appendPathComponent(BackEndUtils.PathComponent.lists.rawValue)
//
//            let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.delete.rawValue, body: nil)
//            URLSession.shared.dataTask(with: request) { (data, res, er) in
//                if let er = er {
//                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
//                    return
//                }
//
//                if let response = res, let data = data  {
//                    print("Delete All Lists Response", response, BackEndUtils.convertDataToJson(data: data))
//                }
//            }.resume()
            
        }

        func callAllLists(completion: @escaping([SList]?)->()) {
            networkCall(objectToSend: nil, queryItems: [], pathComponents: [BackEndUtils.PathComponent.lists.rawValue], requestMethod: .get) { (lists) in
                completion(lists)
            }
        }

        func addUser(to list: SList, user: User, completion:@escaping(SList?)->()) {

            
        }
        ///Goes through all the fetched lists, creates them with listController, then returns them in the returning array.
        func parseFetchedLists(lists: [[String:Any]]) -> [SList]? {
            guard !lists.isEmpty else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return nil}
            var returningLists : [SList] = []

            for i in lists {
                guard let uuid = i["uuid"] as? String,
                    let listMasterID = i["listMasterID"] as? String,
                    let title = i["title"] as? String else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return nil}
                let fetchedList = ListController.createList(title: title, listMasterID: listMasterID, uuid: uuid)
                returningLists.append(fetchedList)

            }

            if returningLists.isEmpty {
                return nil
            }
            return returningLists
        }
        
        private func getParams(list: SList?) -> [String:Any] {
            guard let list = list else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return [:]}

            let params : [String:Any] = ["uuid":list.uuid,"title":list.title,"listMasterID":list.listMasterID]
            return params
        }
        
        func getParams(for lists: [SList]) -> [[String:Any]] {
            var returningArray: [[String:Any]] = []
            for list in lists {
                returningArray.append(getParams(list: list))
            }
            return returningArray
        }
        
    }
}
extension ListController.BackEnd : BackEndRequester {

    
    
    typealias MyType = SList
    
    var parseFetched: ([[String : Any]]) -> [SList]? {
        return parseFetchedLists
    }
    
    var getParameters: (SList?) -> [String : Any] {
        return getParams
    }
    
    var url: URL {
        return BackEndUtils.currentServerUrl!
    }
}
