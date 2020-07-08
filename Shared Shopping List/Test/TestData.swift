//
//  TestData.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class TestFunctions {
    
    static var users : [String:User] = [:]
    static var groups : [String:Group] = [:]
    static var lists : [String:Group] = [:]
    
    init() {
        createUsers()
        createGroups()
    }
    
    func createUsers() {
        let user1 = User(name: "Greg", email: "greghughes988@gmail.com", id: "1", groups: [])
        let user2 = User(name: "Miriam", email: "miriam@gmail.com", id: "2", groups: [])
        let user3 = User(name: "Lisa", email: "lisa@gmail.com", id: "3", groups: [])
        let user4 = User(name: "Wendy", email: "Wendy@gmail.com", id: "4", groups: [])
        let user5 = User(name: "Dad", email: "dad@gmail.com", id: "5", groups: [])
        
        
        TestFunctions.users["Greg"] = user1
        TestFunctions.users["Miriam"] = user2
        TestFunctions.users["Lisa"] = user3
        TestFunctions.users["Wendy"] = user4
        TestFunctions.users["Dad"] = user5
        
    }
    
    func createGroups(){
        let group1 = Group(name: "Group1", id: "1", password: "password1", masterUser: TestFunctions.users["Greg"]!, lists: [])
        let group2 = Group(name: "Group2", id: "2", password: "password2", masterUser: TestFunctions.users["Miriam"]!, lists: [])
        
        TestFunctions.users["Greg"]?.groups.append(group1)
        TestFunctions.users["Miriam"]?.groups.append(group2)
        TestFunctions.groups["Group1"] = group1
        TestFunctions.groups["Group2"] = group2
    }
    
    func createLists() {
//        TestFunctions.users["Greg"]
        let list = List(title: "list1", listMaster: TestFunctions.users["Greg"]!, group: TestFunctions.groups["Group1"]!, items: [])
    }
}
