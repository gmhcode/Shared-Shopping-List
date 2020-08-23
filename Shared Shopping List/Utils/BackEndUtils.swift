//
//  BackEndUtils.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/20/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

struct BackEndUtils {
    static func requestGenerate(url: URL, method: String, body: Data?) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        return request
    }
    
    static func convertDataToJson(data: Data) -> [String:Any] {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print("data \(#file) \(#line) ",json)
                return json
            }
        }catch let er{
            
            print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
            return [:]
        }
        return [:]
    }
    
    static func deleteWholeDatabase(completion:@escaping()->()) {
//        let preUrl = URL(string: "http://localhost:8081/deleteAll")!
//        let request = requestGenerate(url: preUrl, method: "DELETE", body: nil)
//        URLSession.shared.dataTask(with: request) { (data, res, er) in
//            if let error = er {
//                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line)")
//                completion()
//                return
//            }
//            completion()
//        }.resume()
    }
    
    enum RequestMethod : String {
        case update = "PUT"
        case post = "POST"
        case get = "GET"
        case delete = "DELETE"
    }
    
    enum PathComponent: String {
        case user = "user"
        case users = "users"
        case list = "list"
        case lists = "lists"
        case item = "item"
        case items = "items"
        
    }
    
}
