//
//  UserController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    static let shared = UserController()
    static var currentUser : User?
    
    static func createUser(name:String, email: String) -> User {
        let persistentManager = PersistenceManager.shared
        let user = User(context: persistentManager.context)
        user.name = name
        user.email = email
        user.uuid = UUID().uuidString
        persistentManager.saveContext()
        return user
    }
    
    ///Gets the List from the entered ID
    static func getUser(id: UUID) -> User? {
        
        let persistentManager = PersistenceManager.shared
        let request : NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let user = try persistentManager.context.fetch(request)
            if user.count > 0 {
                return user[0]
            } else {
                return nil
            }
        } catch  {
            print("array could not be retrieved \(error)")
            return nil
        }
    }
    
    ///Gets all lists
    static func getAllUsers() -> [User] {
        let persistentManager = PersistenceManager.shared
        let users = persistentManager.fetch(User.self)
        return users
    }
    
    ///Deletes list with the entered ID
    static func deleteUser(id:UUID) {
        let persistentManager = PersistenceManager.shared
        let user = getUser(id: id)
        if user != nil {
            persistentManager.delete(user!)
        }
        persistentManager.saveContext()
    }
    static func deleteAllUsers() {
        let persistentManager = PersistenceManager.shared
        let item = getAllUsers()
        
        for i in item {
            persistentManager.delete(i)
        }
        persistentManager.saveContext()
    }
    
    ///Change the list's title
    static func changeName(id:UUID, newName: String) {
        guard let user = getUser(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        let persistentManager = PersistenceManager.shared
        user.name = newName
        persistentManager.saveContext()
    }
    
    ///Update the name and store of the Item of the entered ID
    static func updateUser(name: String, id: UUID, email: String) {
        let persistentManager = PersistenceManager.shared
        guard let user = getUser(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        
        user.email = email
        user.name = name
        
        persistentManager.saveContext()
    }
    
}
