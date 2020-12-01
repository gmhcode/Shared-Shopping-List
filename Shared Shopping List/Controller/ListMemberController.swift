//
//  ListMemberController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 8/15/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import CoreData
class ListMemberController {
    
    @discardableResult static func createListMember(listID: String, userID: String, uuid: String?) -> ListMember {
        let uuid = (uuid != nil ? uuid : userID + listID ) ?? ""
        if let listMember = getListMember(id: uuid) {
            return listMember
        }
        
        let persistentManager = PersistenceManager.shared
        let listMember = ListMember(context: persistentManager.context)
        
        listMember.uuid = uuid
        listMember.listID = listID
        listMember.userID = userID
        persistentManager.saveContext()
        return listMember
    }
    
    static func getListMember(id: String) -> ListMember? {
        
        let persistentManager = PersistenceManager.shared
        let request : NSFetchRequest<ListMember> = ListMember.fetchRequest()
        let predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let listMember = try persistentManager.context.fetch(request)
            if listMember.count > 0 {
                return listMember[0]
            } else {
                return nil
            }
        } catch  {
            print("array could not be retrieved \(error)")
            return nil
        }
    }
    struct BackEnd {
        static let shared = BackEnd()
        
        func createCodableListMember(listID:String,userID:String,userName: String, completion:@escaping(CodableListMember)->()) {
            let listmember = CodableListMember(listID: listID, userID: userID, uuid: "", userName: userName)
            
            networkCall(objectToSend: listmember, queryItems: [], pathComponents: [BackEndUtils.PathComponent.listMember.rawValue], requestMethod: .post) { (listMember) in
                completion(listmember)
            }
            
        }
        
        
        func getListMembers(for lists: [CodableList], completion: @escaping ([CodableListMember]?)->()) {
            let url = URL(string: "http://localhost:8081/listMembers/withLists")!
            
            
            
            guard let json = try? JSONEncoder().encode(lists), let convertedLists = try? JSONSerialization.jsonObject(with: json, options: []) as? [[String: Any]] else{completion(nil); return}
            
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: convertedLists, options: .init())
                let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.post.rawValue, body: requestBody)
                
                URLSession.shared.dataTask(with: request) { (data, res, er) in
                    if let er = er {
                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                        completion(nil)
                        return
                    }
                    
                    guard let data = data else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion(nil);return}
                    let json = BackEndUtils.convertArrayDataToJson(data: data)
                    let listMembers = self.parseFetchedListMembers(listMembers: json)
                    
                    completion(listMembers)
                }.resume()
            } catch let er {
                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                completion(nil)
            }
        }
        func deleteListMember(listMember: CodableListMember, completion:@escaping()->()) {
            let url = URL(string: "http://localhost:8081/listMember/\(listMember.uuid)")!
            
            let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.delete.rawValue, body: nil)
            
            URLSession.shared.dataTask(with: request) { (data, res, er) in
                if let er = er {
                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                    completion()
                    return
                }
                
                guard let data = data else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion();return}
                completion()
                let decoder = JSONDecoder()
                
                do {
                    //                    let jsonDecoder = JSONDecoder()
                    //                    let listMember = try? jsonDecoder.decode(, from: <#T##Data#>)
                    //                    completion(listMembers)
                } catch let er {
                    
                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                }
                
                
            }.resume()
        }
        func addListMember(listMember: ListMember, completion: @escaping(ListMember?)->()) {
            //            let url = URL(string: "http://localhost:8081/listMember")!
            //            let convertedLM = getParams(listMember: listMember)
            //
            //            do {
            //                let requestBody = try JSONSerialization.data(withJSONObject: convertedLM, options: .init())
            //                let request = BackEndUtils.requestGenerate(url: url, method: "POST", body: requestBody)
            //                URLSession.shared.dataTask(with: request) { (data, res, er) in
            //                    if let er = er {
            //                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
            //                        completion(nil)
            //                        return
            //                    }
            //
            //                    guard let data = data else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion(nil);return}
            //                    let json = BackEndUtils.convertDataToJson(data: data)
            //                    let listMember = self.parseFetchedListMembers(listMembers: [json])
            //
            //                    completion(listMember?[0])
            //                }.resume()
            //            } catch let er {
            //                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
            //                completion(nil)
            //            }
        }
        
        func parseFetchedListMembers(listMembers: [[String:Any]]) -> [CodableListMember]? {
            guard !listMembers.isEmpty else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return nil}
            var returningLists : [CodableListMember] = []
            
            for i in listMembers {
                guard let uuid = i["uuid"] as? String,
                      let userID = i["userID"] as? String,
                      let listID = i["listID"] as? String,
                      let userName = i["userName"] as? String else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return nil}
                let fetchedListMember = CodableListMember(listID: listID, userID: userID, uuid: uuid, userName: userName)
                
                //                    ListMemberController.createListMember(listID: listID, userID: userID, uuid: uuid)
                returningLists.append(fetchedListMember)
                
            }
            
            if returningLists.isEmpty {
                return nil
            }
            return returningLists
        }
        
        func getParams(listMember: CodableListMember?) -> [String:Any] {
            guard let listMember = listMember else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return [:]}
            
            let params : [String:Any] = ["listID":listMember.listID,"userID":listMember.userID,"uuid":listMember.uuid,"userName":listMember.userName]
            return params
        }
    }
    
    //    type ListMember struct {
    //        ListID string `json:"listID" gorm:"column:listID"`
    //        UserID string `json:"userID" gorm:"column:userID"`
    //        UUID   string `json:"uuid" gorm:"primary_key"`
    //    }
}
extension ListMemberController.BackEnd : BackEndRequester {
    var url: URL {
        return BackEndUtils.currentServerUrl!
    }
    
    var getParameters: (CodableListMember?) -> [String : Any] {
        return getParams
    }
    
    var parseFetched: ([[String : Any]]) -> [CodableListMember]? {
        return parseFetchedListMembers
    }
    
    typealias MyType = CodableListMember
    
    
}
