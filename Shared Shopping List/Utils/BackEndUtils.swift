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
        let preUrl = URL(string: "http://localhost:8081/deleteAll")!
        let request = requestGenerate(url: preUrl, method: "DELETE", body: nil)
        URLSession.shared.dataTask(with: request) { (data, res, er) in
            if let error = er {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line)")
                completion()
                return
            }
            completion()
        }.resume()
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


protocol BackEndRequester {
    associatedtype MyType
    var url : URL { get }
    var getParameters : (MyType?) -> [String:Any] { get }
    var parseFetched: ([[String:Any]]) -> [MyType]? { get }
}


extension BackEndRequester {
    func networkCall(objectToSend: MyType?, queryItems: [URLQueryItem], pathComponents: [String], requestMethod: BackEndUtils.RequestMethod, completion:@escaping ([MyType]?)->()) {
        
        guard let url = createUrl(queryItems: queryItems, pathComponents: pathComponents) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion(nil); return}
        
        //Build request
        let params = getParameters(objectToSend)
        let requestBody = params.isEmpty ? nil : try? JSONSerialization.data(withJSONObject: params, options: .init())
        let request = requestGenerate(url: url, method: requestMethod.rawValue, body: requestBody)
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line), for Type 🇧🇱  \(String(describing: MyType.self))")
                completion(nil)
                return
            }
            if response != nil {
                print("Server response: ",response as Any)
            }
            guard let data = data else {print("❇️♊️>>>\(#file) \(#line): , for Type 🇧🇱  \(String(describing: MyType.self)) guard let failed<<<"); completion(nil); return}
            
            do {
                if let json = try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String:Any] {
                    
                    if let objects = self.parseFetched([json]) {
                        completion(objects)
                        return
                    }
                }else if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String:Any]] {
                    if let objects = self.parseFetched(json) {
                        completion(objects)
                        return
                    }
                }
            }catch let er{
                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line) , for Type 🇧🇱  \(String(describing: MyType.self))")
            }
            completion(nil)
            return
        }.resume()
    }
    
    private func createUrl(queryItems: [URLQueryItem], pathComponents: [String]) -> URL? {
        var preUrl = self.url
        pathComponents.forEach({preUrl.appendPathComponent($0)})
        var componentes = URLComponents(url: preUrl, resolvingAgainstBaseURL: true)
        componentes?.queryItems = queryItems
        return componentes?.url
    }
    
    
    private func requestGenerate(url: URL, method: String, body: Data?) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        return request
    }
}
