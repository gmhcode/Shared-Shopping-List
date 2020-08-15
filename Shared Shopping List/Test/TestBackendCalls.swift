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
        
    }
    
//    func createLists() {
//        let list1 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
//        let list2 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
//        let list3 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
//
//    }
    
    func createLists(users: [User]) {
        
        let listCount = 3
        
        for (userIndex,user) in users.enumerated() {
            
            for (listIndex,list) in [0...listCount].enumerated() {
                
                let list = ListController.createList(title: "\(user.name)'s list \(listIndex)", listMasterID: user.uuid, uuid: "\(user.name)ID\(listIndex)")
                ListController.BackEnd.shared.createList(list: list) {
                    
                }
            }
        }
    }
    
    class Gregs {
        
        static func createGreg() {
            let user = UserController.createUser(name: "Greg", email: "greg@greg.com", uuid: "gregid")
            UserController.BackEnd.shared.createUser(user: user)
        }
        
        static func createGregsLists() {
            let list1 = ListController.createList(title: <# #>, listMasterID: <#T##String#>, uuid: <#T##String#>)
            let list2 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
            let list3 = ListController.createList(title: <#T##String#>, listMasterID: <#T##String#>, uuid: <#T##String#>)
            
            
            
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
