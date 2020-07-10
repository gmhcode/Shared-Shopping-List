//
//  Item.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/5/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class Item {
    var name : String
    var store : String
    var userSent : User
    var list : List
    
    init(name: String, store: String, userSent: User, list: List) {
        self.name = name
        self.store = store
        self.userSent = userSent
        self.list = list
    }
}
