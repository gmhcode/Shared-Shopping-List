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
    
    static func createUser(name:String, email: String) -> User {
        let persistentManager = PersistenceManager.shared
        let user = User(context: persistentManager.context)
        user.name = name
        user.email = email
        user.id = UUID()
        persistentManager.saveContext()
        return user
    }
    
    
    
}
