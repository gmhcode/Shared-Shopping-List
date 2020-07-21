//
//  UserBackEndController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/20/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class UserBackEndController {
    static var testUsers: [User] = []
    static var shared = UserBackEndController()
    let url = URL(string: "http://192.168.1.225:8081/")
    
    
    func createUser() {
        guard let url = url else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}


    }
    
    
}
