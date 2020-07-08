//
//  Group.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/5/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class Group {
    init(name: String, id: String, password: String, masterUser: User, lists: [List]) {
        self.name = name
        self.id = id
        self.password = password
        self.masterUser = masterUser
        self.lists = lists
    }
    
    
    var name : String
    var id : String
    var password : String
    var masterUser : User
    var lists : [List]

}
