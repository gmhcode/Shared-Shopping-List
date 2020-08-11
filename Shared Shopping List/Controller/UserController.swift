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
    static var currentUser : User?
    
    static func createUser(name:String, email: String, uuid: String) -> User {
        
        if let list = getUser(id: uuid) {
            return list
        }
        
        let persistentManager = PersistenceManager.shared
        let user = User(context: persistentManager.context)
        user.name = name
        user.email = email
        user.uuid = uuid
        //            UUID().uuidString
        persistentManager.saveContext()
        return user
    }
    
    ///Gets the List from the entered ID
    static func getUser(id: String) -> User? {
        
        let persistentManager = PersistenceManager.shared
        let request : NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
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
    static func deleteUser(id:String) {
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
    static func changeName(id:String, newName: String) {
        guard let user = getUser(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        let persistentManager = PersistenceManager.shared
        user.name = newName
        persistentManager.saveContext()
    }
    
    ///Update the name and store of the Item of the entered ID
    static func updateUser(name: String, id: String, email: String) {
        let persistentManager = PersistenceManager.shared
        guard let user = getUser(id: id) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        
        user.email = email
        user.name = name
        
        persistentManager.saveContext()
    }
    
    struct BackEnd {
        
        static var testUsers: [String : User] = [:]
        static var shared = UserController.BackEnd()
        var url = URL(string: "http://localhost:8081/")
        
        func parseFetchedUsers(users: [[String:Any]]) -> [User]? {
            guard !users.isEmpty else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return nil}
            var returningUsers : [User] = []
            
            for i in users {
                guard let uuid = i["uuid"] as? String,
                    let name = i["name"] as? String,
                    let email = i["email"] as? String else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); continue}
                let fetchedUser = UserController.createUser(name: name, email: email, uuid: uuid)
                
                returningUsers.append(fetchedUser)
                
            }
            
            if returningUsers.isEmpty {
                return nil
            }
            return returningUsers
        }
        
        
        func getUsersWithList(list: List, completion:@escaping ([User]?) ->()) {
            let preUrl = URL(string: "http://localhost:8081/users/query")!
            
            let query = URLQueryItem(name: "listID", value: list.uuid)

            var components = URLComponents(url: preUrl, resolvingAgainstBaseURL: true)
            components?.queryItems = [query]
            guard let url = components?.url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<");completion(nil); return}

            var request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.get.rawValue, body: nil)
            
            URLSession.shared.dataTask(with: request) { (data, res, error) in
                if let error = error {
                    print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line)")
                    completion(nil)
                    return
                }
                guard let data = data else {completion(nil); return}
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String:Any]] {
                        if let users = self.parseFetchedUsers(users: json) {
                            completion(users)
                            return
                        }
                    }
                }catch let er{
                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                }
              completion(nil)
            }.resume()
            
        }
        
        func callAllUsers(completion: @escaping ([User]?) -> ()) {
            //http://192.168.1.225:8081/listMembers
            var url = URL(string: "http://localhost:8081/users")! 
            
//            var preUrl = URL(string: "http://localhost:8081/users/query")!
//
//            let query = URLQueryItem(name: "foo", value: "bar")
//
//            var components = URLComponents(url: preUrl, resolvingAgainstBaseURL: true)
//            components?.queryItems = [query]
//            var url = components?.url
            
            
            var request = URLRequest(url: url)
            
            request.httpMethod = BackEndUtils.RequestMethod.get.rawValue
            
            URLSession.shared.dataTask(with: request) { (data, res, er) in
                guard let data = data else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion(nil); return}
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String:Any]] {
                        if let users = self.parseFetchedUsers(users: json){
                            completion(users)
//                            print("🛳 users",json)
                            return
                        }
                    }
                    completion(nil)
                }catch let er{
                    
                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                    completion(nil)
                }
            }.resume()
        }
        
        func createUser(user: User) {
            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            url.appendPathComponent(BackEndUtils.PathComponent.user.rawValue)
            
            let params : [String:Any] = getParams(user: user)
            
            
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: params, options: .init())
                let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.post.rawValue, body: requestBody)
                
                URLSession.shared.dataTask(with: request) { (data, res, er) in
                    if let er = er {
                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                        return
                    }
                    
                    if let response = res, let data = data  {
                        print("Create User Response", BackEndUtils.convertDataToJson(data: data))
                    }
                    
                }.resume()
                
            } catch let err {
                print("❌ There was an error in \(#function) \(err) : \(err.localizedDescription) : \(#file) \(#line)")
            }
        }
        
        func updateUser(user: User) {
            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            url.appendPathComponent(BackEndUtils.PathComponent.user.rawValue)
            
            let params : [String:Any] = getParams(user: user)
            
            
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: params, options: .init())
                let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.update.rawValue, body: requestBody)
                URLSession.shared.dataTask(with: request) { (data, res, er) in
                    if let er = er {
                        print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                        return
                    }
                    
                    if let response = res, let data = data  {
                        print("Update User Response 🚘", BackEndUtils.convertDataToJson(data: data))
                    }
                    
                }.resume()
                
            } catch let err {
                print("❌ There was an error in \(#function) \(err) : \(err.localizedDescription) : \(#file) \(#line)")
            }
        }
        
        func deleteAllUsers() {
            guard var url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            url.appendPathComponent(BackEndUtils.PathComponent.users.rawValue)
            
            let request = BackEndUtils.requestGenerate(url: url, method: BackEndUtils.RequestMethod.delete.rawValue, body: nil)
            URLSession.shared.dataTask(with: request) { (data, res, er) in
                if let er = er {
                    print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                    return
                }
                
                if let response = res, let data = data  {
                    print("Create User Response", BackEndUtils.convertDataToJson(data: data))
                }
                
            }.resume()
        }
        
        func getParams(user: User) -> [String:Any] {
            let params : [String:Any] = ["name":user.name,"email":user.email,"uuid":user.uuid]
            return params
        }
    }
}
