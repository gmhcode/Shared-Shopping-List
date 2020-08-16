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

    @discardableResult static func createListMember(listID: String, userID: String) -> ListMember {
        let uuid = userID + listID
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
        
        func addListMember(listMember: ListMember, completion: @escaping(ListMember?)->()) {
            let url = URL(string: "http://localhost:8081/listMember")!
            let convertedLM = getParams(listMember: listMember)
            
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: convertedLM, options: .init())
                let request = BackEndUtils.requestGenerate(url: url, method: "POST", body: requestBody)
                URLSession.shared.dataTask(with: request) { (data, res, er) in
                    if let er = er {
                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                        completion(nil)
                        return
                    }
                
                    guard let data = data else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion(nil);return}
                    let json = BackEndUtils.convertDataToJson(data: data)

                
                }.resume()
            } catch let er {
                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                completion(nil)
            }
        }
        
//        func parseFetchedListMembers(listMembers: [[String:Any]]) -> [ListMember]? {
//            guard !listMember.isEmpty else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return nil}
//            var returningLists : [List] = []
//            
//            for i in listMember {
//                guard let uuid = i["uuid"] as? String,
//                    let listMasterID = i["listMasterID"] as? String,
//                    let title = i["title"] as? String else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return nil}
//                let fetchedList = ListController.createList(title: title, listMasterID: listMasterID, uuid: uuid)
//                returningLists.append(fetchedList)
//                
//            }
//            
//            if returningLists.isEmpty {
//                return nil
//            }
//            return returningLists
//        }
       
        func getParams(listMember: ListMember) -> [String:Any] {
            let params : [String:Any] = ["listID":listMember.listID,"userID":listMember.userID,"uuid":listMember.uuid]
            return params
        }
    }
    
//    type ListMember struct {
//        ListID string `json:"listID" gorm:"column:listID"`
//        UserID string `json:"userID" gorm:"column:userID"`
//        UUID   string `json:"uuid" gorm:"primary_key"`
//    }
}
