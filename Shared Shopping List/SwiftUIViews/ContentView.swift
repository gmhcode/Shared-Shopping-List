//
//  ContentView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 10/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var listVM = ListViewModel()
    
    var body: some View {
        let color = 0.0
        List(listVM.lists.indices, id:\.self) { index in
            ListCell(title: listVM.lists[index].title, brightness: (color - (0.1 * Double(index)))).onAppear(perform: {
                }).cornerRadius(10)
            }
            .onAppear(perform: {
                UITableView.appearance().separatorColor = .clear
                print("🚛",listVM.lists.count)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//http://192.168.1.43:8081/items
class Listi: Codable, Identifiable {
    
    
    let uuid : String
    let title: String
    let listMasterID : String
    
    init(uuid: String, title: String, listMasterID: String) {
        self.uuid = uuid
        self.title = title
        self.listMasterID = listMasterID
    }
    
    
   
}
