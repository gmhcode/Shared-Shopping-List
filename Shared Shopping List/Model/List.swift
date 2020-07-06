//
//  List.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 6/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class List {
    
    var title : String
    var listMaster: String
    
    init(title: String, listMaster: String) {
        self.title = title
        self.listMaster = listMaster
    }
}
