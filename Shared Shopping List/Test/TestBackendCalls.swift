//
//  TestBackendCalls.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/20/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
class TestBackEndFuncs {
    
    func createTestData() {
        
        
        var userArray :[User] = []
        createGreg { (user) in
            userArray.append(user)
            self.createMiriam { (miriam) in
                userArray.append(miriam)
                self.createMom { (mom) in
                    userArray.append(mom)
                    self.createDad { (dad) in
                        userArray.append(dad)
                        self.createListsAndAddUsers(userArray: userArray)
                    }
                }
            }
        }
    }
    

    func createListsAndAddUsers(userArray:[User]){
        self.createLists(users: userArray) {listDict in
            self.addExtraUsersToLists(listsDict: listDict)
        }
    }
    
    func createLists(users: [User], completion:@escaping ([User : [List]] )->()){
        
        ListController.BackEnd.shared.deleteAllLists()
        ListController.deleteAllLists()
        let listCount = 3
        var listsDict : [User : [List]] = [:]
        //creates lists for each user
        for (_,user) in users.enumerated() {
            var listArray : [List] = []
            for (listIndex,_) in [0...listCount].enumerated() {
                
                let list = ListController.createList(title: "\(user.name)'s list \(listIndex)", listMasterID: user.uuid, uuid: "\(user.name)ID\(listIndex)")
                ListController.BackEnd.shared.createList(list: list) {
                    //if we are on the last user and on the last list index, completion
                    if user.uuid == users.last?.uuid && listIndex == listCount {
                        completion(listsDict)
                    }
                }
                
                listArray.append(list)
                listsDict[user] = listArray
            }
        }
    }
    
    func addExtraUsersToLists(listsDict: [User : [List]]) {
        //adds a user
        for user in listsDict.keys {
            for i in listsDict.keys {
                if i.uuid != user.uuid {
                    let list1ID = listsDict[i]![0].uuid
                    let list2ID = listsDict[i]![1].uuid
                    ListMemberController.createListMember(listID: list1ID, userID: i.uuid, uuid: nil)
                    
                    ListMemberController.createListMember(listID: list2ID, userID: i.uuid, uuid: nil)
                }
            }
        }
    }
    
    
    func createGreg(completion:@escaping(User)->())  {
        let user = UserController.createUser(name: "Greg", email: "greg@greg.com", uuid: "gregid")
        UserController.BackEnd.shared.createUser(user: user, completion: {user in
            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            
            completion(user)
        })
    }
    func createMiriam(completion:@escaping(User)->())  {
        let user = UserController.createUser(name: "Miriam", email: "Miriam@Miriam.com", uuid: "Miriamid")
        UserController.BackEnd.shared.createUser(user: user, completion: {user in
            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            
            completion(user)
        })
    }
    func createMom(completion:@escaping(User)->())  {
        let user = UserController.createUser(name: "Mom", email: "Mom@Mom.com", uuid: "Momid")
        UserController.BackEnd.shared.createUser(user: user, completion: {user in
            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            
            completion(user)
        })
    }
    func createDad(completion:@escaping(User)->())  {
        let user = UserController.createUser(name: "Dad", email: "Dad@Dad.com", uuid: "Dadid")
        UserController.BackEnd.shared.createUser(user: user, completion: {user in
            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            
            completion(user)
        })
    }
    
    
    func deleteAllDataFromDatabases(completion:@escaping()->()) {
        BackEndUtils.deleteWholeDatabase(completion: {
            
            UserController.deleteAllUsers()
            ListController.deleteAllLists()
            ItemController.deleteAllItems()
            completion()
        })
        
    }
    
    
}
