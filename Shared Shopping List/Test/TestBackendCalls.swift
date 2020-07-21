//
//  TestBackendCalls.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/20/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
class TestBackEndFuncs {
    
    
    static func callUsers() {
        //http://192.168.1.225:8081/listMembers
        let url = URL(string: "http://192.168.1.225:8081/listMembers")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, res, er) in
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {
                    print("data",json)
                }
            }catch let er{
                
                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
            }
            
        }.resume()

        
    }
    
    
}
