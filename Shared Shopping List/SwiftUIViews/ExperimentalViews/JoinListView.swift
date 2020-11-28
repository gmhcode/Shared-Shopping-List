//
//  addListMemberView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/25/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct JoinListView: View {
    @State var newMemberName = ""
    @ObservedObject var listVM = listViewModel
    var body: some View {
        VStack (spacing: 30){
                HStack {
                    Text("list name")
                    Spacer()
                }
                TextField("Enter The New List Member Here", text: $newMemberName)
                
                Button(action: {
                    if newMemberName.trimmingCharacters(in: .whitespaces) != ""  {
//                        listVM.addUserToList(newUserID: <#T##String#>, list: <#T##CodableList#>)
                        listVM.showCreateListView.toggle()
                    }
                }, label: {
                    Text("Join List")
                }).padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                
            }
            .background(Color.white)
            .padding()
    }
}

struct addListMemberView_Previews: PreviewProvider {
    static var previews: some View {
        JoinListView(listVM: listViewModel)
    }
}
