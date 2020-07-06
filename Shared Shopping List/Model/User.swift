//
//  User.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/5/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class User {
    
    var name : String
    var email : String
    var id : String
    
    init(name: String, email: String, id : String) {
        self.name = name
        self.email = email
        self.id = id
    }
}
