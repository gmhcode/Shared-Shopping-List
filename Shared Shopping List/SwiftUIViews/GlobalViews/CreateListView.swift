//
//  CreateListView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/19/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct CreateListView: View {
    @State var listTitle = ""
    @State var listMaster = ""
    @ObservedObject var listVM : ListViewModel
    var body: some View {
        
        VStack (spacing: 30){
            HStack {
                Text("list name")
                Spacer()
            }
            TextField("Enter your listName here", text: $listTitle)
            
            HStack {
                Spacer()
                Button(action: {
                    listVM.showCreateListView.toggle()
                }, label: {
                    Text("Cancel")
                }).padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                Spacer()
                Button(action: {
                    if listTitle.trimmingCharacters(in: .whitespaces) != ""  {
                        listVM.createList(uuid: "", title: listTitle, listMasterID: mainUser.name)
                        listVM.showCreateListView.toggle()
                    }
                    
                }, label: {
                    Text("Add list")
                }).padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
        )
    }
}

struct CreateListView_Previews: PreviewProvider {
    static var previews: some View {
        let listVM = ListViewModel()
        CreateListView(listVM: listVM)
    }
}
