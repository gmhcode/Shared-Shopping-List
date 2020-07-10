////
////  TestData.swift
////  Shared Shopping List
////
////  Created by Greg Hughes on 7/7/20.
////  Copyright © 2020 Greg Hughes. All rights reserved.
////
//
//import Foundation
//
//class TestFunctions {
//    
//    static var users : [String:User] = [:]
//    static var groups : [String:Group] = [:]
//    static var lists : [String:Group] = [:]
//    
//    init() {
//        createUsers()
//        createGroups()
//        createLists()
//        createItems()
//    }
//    
//    func createUsers() {
//        let user1 = UserController.createUser(name: "Greg", email: "greg@gmail.com", id: "1", groups: [:])
//        
//        TestFunctions.users["Greg"] = user1
//        
//        
//    }
//    
//    func createGroups(){
//        let group1 = Group(name: "Group1", id: "1", password: "password1", masterUser: TestFunctions.users["Greg"]!, lists: [])
//        
//        UserController.joinGroup(user: TestFunctions.users["Greg"]!, group: group1)
//
//        TestFunctions.groups["Group1"] = group1
//    }
//    
//    func createLists() {
////        TestFunctions.users["Greg"]
//        let list = List(title: "list1", listMaster: TestFunctions.users["Greg"]!, groupID: TestFunctions.groups["Group1"]!.id, items: [])
//        TestFunctions.groups["Group1"]?.lists.append(list)
//    }
//    
//    func createItems() {
//        let item = Item(name: "item 1", store: "smiths", userSent: TestFunctions.users["Greg"]!, list: (TestFunctions.groups["Group1"]?.lists[0])!)
//    }
//}
