//
//  UserController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class UserController {
    static let shared = UserController()
    static var currentUser : User?
    var users = [String:User]()
    
    static func createUser(name: String, email: String, id: String, groups: [Group]) -> User {
        let user = User(name: name, email: email, id: id, groups: groups)
//        users[id] = user
        return user
    }

    func readUser(name: String, email: String, id: String, groups: [Group]) {
//        if users[id] != nil {
//            users[id]?.name = name
//            users[id]?.email = email
//            users[id]?.groups = groups
//        }
    }

    func updateUser(name: String, email: String, id: String, groups: [Group]) {
        
        if users[id] != nil {
            users[id]?.name = name
            users[id]?.email = email
            users[id]?.groups = groups
        }
        
    }

    func deleteUser(user: User) {
        users.removeValue(forKey: user.id)
    }
    
}
