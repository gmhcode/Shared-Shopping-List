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
        
        let greg = Gregs()
        
        var userArray :[User] = []
        greg.createMe { (user) in
            userArray.append(user)
        }
        //createLists(users: userArray) {listDict in
//        addExtraUsersToLists(listsDict: listDict)
//    }
    }
    
//    func createLists() {
//        let list1 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
//        let list2 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
//        let list3 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
//
//    }
    
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
                    listsDict[i]?[0].uuid //add user as a list member
                    listsDict[i]?[1].uuid //add user as a list member
                }
            }
        }
    }
    
    class Gregs {
        
        func createMe(completion:@escaping(User)->())  {
            let user = UserController.createUser(name: "Greg", email: "greg@greg.com", uuid: "gregid")
            UserController.BackEnd.shared.createUser(user: user, completion: {user in
                guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

                completion(user)
            })
        }
        
        static func createGregsLists() {
//            let list1 = ListController.createList(title: <# #>, listMasterID: <#T##String#>, uuid: <#T##String#>)
//            let list2 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
//            let list3 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
            
            
            
        }
    }
    class Miriams {
        
    }
    class Moms {
        
    }
    class Dads {
        
    }
    
    func deleteTestData() {
        BackEndUtils.deleteWholeDatabase()
    }
    
    
}
