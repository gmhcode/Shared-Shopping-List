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
    
    @ObservedObject var listVM = listViewModel
    init() {
        listViewModel.fetchLists()
    }
    var body: some View {
        let color = 0.0
        ZStack {
            VStack {
                Text(listVM.mostRecentList?.title ?? "  ")
                CreateDeleteListButtons(listVM: listVM)
                //Need to create a list via this method, so we can have the cells change colors
                List(listVM.listAndItemsAndListMembers.lists.indices, id:\.self) { index in
                    
                    ListCell(list: listVM.listAndItemsAndListMembers.lists[index], itemCount: listVM.countListItems(list: listVM.listAndItemsAndListMembers.lists[index]), brightness: (color - (0.1 * Double(index))))
                        .onTapGesture{
                            let list = listVM.listAndItemsAndListMembers.lists[index]
                            listVM.joinList(joinerPassword: "4321")
//                            listVM.addUserToList(newUserID: "gregid", list: listVM.listAndItemsAndListMembers.lists[index])
                            SwiftUIListViewController.vc?.navigateToListDetails(list:list)
                            listVM.setMostRecentList(list: listVM.listAndItemsAndListMembers.lists[index])
                        }
                        .cornerRadius(10)
                    }
                    .onAppear(perform: {
                        UITableView.appearance().separatorColor = .clear

                })
            }
            if listVM.showCreateListView {
                CreateListView(listVM: listVM)
            }else if listVM.showDeleteListView {
                DeleteListView(listVM: listVM)
            }else if listVM.addListMemberView {
                
            }else if listVM.removeListMemberView {
                
            }
        }
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
