//
//  List.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 6/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class List {
    
    init(title: String, listMaster: User, groupID: String, items: [Item]) {
        self.title = title
        self.listMaster = listMaster
        self.groupID = groupID
        self.items = items
    }
    
    
    var title : String
    var listMaster: User
    var groupID : String
    var items : [Item]
   
}
