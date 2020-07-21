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
                print("data",json)
                return json
            }
        }catch let er{
            
            print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
            return [:]
        }
        return [:]
    }
}
