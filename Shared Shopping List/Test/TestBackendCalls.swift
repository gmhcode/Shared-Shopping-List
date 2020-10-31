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
        
        
        var userArray: [User] = []
        
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
            let array = ListController.getAllLists()
//            let array = listDict.values.map({$0}).reduce([], +)
            
            self.addExtraUsersToLists(listsDict: listDict)
            self.populateItems(users: userArray, lists: array)
        }
    }
    
    func createLists(users: [User], completion:@escaping ([User : [SList]] )->()){
        
        ListController.BackEnd.shared.deleteAllLists()
        ListController.deleteAllLists()
        let listCount = 3
        var listsDict : [User : [SList]] = [:]
        //creates lists for each user
        for (_,user) in users.enumerated() {
            var listArray : [SList] = []
            for (listIndex,_) in (0...listCount).enumerated() {
                print("listIndex: ", listIndex)
                let list = ListController.createList(title: "\(user.name)'s list \(listIndex)", listMasterID: user.uuid, uuid: "\(user.name)ID\(listIndex)")
                ListController.BackEnd.shared.createList(list: list) {_ in 
                    //if we are on the last user and on the last list index, completion
                    if user.uuid == users.last?.uuid && listIndex == listCount {
                        completion(listsDict)
                    }
                }
                
                listArray.append(list)
                listsDict[user] = listArray
                print(listArray)
            }
        
        }
    }
    
    func addExtraUsersToLists(listsDict: [User : [SList]]) {
        //adds a user
        for user in listsDict.keys {
            for i in listsDict.keys {
                if i.uuid != user.uuid {
                    let list1ID = listsDict[user]![0]
                    let list2ID = listsDict[user]![1]
                    
                    ListController.addMemberToListFrontAndBack(list: list1ID, newMember: i) {
                        
                    }
                    ListController.addMemberToListFrontAndBack(list: list2ID, newMember: i) {
                        
                    }
                }
            }
        }
    }
    
    func populateItems(users:[User],lists:[SList]) {
        let stores = ["Smiths","Target","Walmart"]
        var counter = 0
        for i in users {
            for list in lists {
                let newNum = counter + 1
                counter = newNum > 2 ? 0 : newNum
                _ = ItemController.BackEnd.shared.createItemFrontAndBack(name: "Item \(counter)\(i.name), \(list.title)", store: stores[counter], userSentID: i.uuid, listID: list.uuid, uuid: UUID().uuidString, completion: { item in
                    
                })
                counter += 1
            }
            
        }
    }
    
    func createGreg(completion:@escaping(User)->())  {
        UserController.BackEnd.shared.createUserFrontAndBack(name: "Greg", email: "greg@greg.com", uuid: "gregid", completion: {user in
            completion(user)
        })
//        UserController.BackEnd.shared.createUser(user: user, completion: {user in
//            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
//
//            completion(user)
//        })
    }
    
    func createMiriam(completion:@escaping(User)->())  {
        UserController.BackEnd.shared.createUserFrontAndBack(name: "Miriam", email: "Miriam@Miriam.com", uuid: "Miriamid", completion: {user in
            completion(user)
        })
//        UserController.BackEnd.shared.createUser(user: user, completion: {user in
//            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
//
//
//        })
    }
    
    func createMom(completion:@escaping(User)->())  {
        _ = UserController.BackEnd.shared.createUserFrontAndBack(name: "Mom", email: "Mom@Mom.com", uuid: "Momid", completion: {user in
            completion(user)
        })
//        UserController.BackEnd.shared.createUser(user: user, completion: {user in
//            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
//
//            completion(user)
//        })
    }
    
    func createDad(completion:@escaping(User)->())  {
        _ = UserController.BackEnd.shared.createUserFrontAndBack(name: "Dad", email: "Dad@Dad.com", uuid: "Dadid", completion: {user in
            completion(user)
        })
//        UserController.BackEnd.shared.createUser(user: user, completion: {user in
//            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
//
//            completion(user)
//        })
    }
    
    
    func deleteAllDataFromDatabases(completion:@escaping()->()) {
        BackEndUtils.deleteWholeDatabase(completion: {
            completion()
        })
        
    }
}
