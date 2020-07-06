//
//  Group.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/5/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class Group {
    
    var name : String
    var id : String
    var lists : String
    
    internal init(name: String, id: String, lists: String) {
        self.name = name
        self.id = id
        self.lists = lists
    }
}
