//
//  addListMemberView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/25/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct JoinListView: View {
    @State var listJoinerPassword = ""
    @ObservedObject var listVM = listViewModel
    var body: some View {
        VStack (spacing: 30){
                HStack {
                    Text("list joiner password")
                    Spacer()
                }
                TextField("Enter The New List password Here", text: $listJoinerPassword)
                
            HStack {
                Spacer()
                Button(action: {
                            listVM.showJoinListView.toggle()
                    }, label: {
                        Text("Cancel")
                    }).padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                )
                Spacer()
                Button(action: {
                        if listJoinerPassword.trimmingCharacters(in: .whitespaces) != ""  {
                            listVM.joinList(joinerPassword: listJoinerPassword)
                            listVM.showJoinListView.toggle()
                        }
                    }, label: {
                        Text("Join List")
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

struct addListMemberView_Previews: PreviewProvider {
    static var previews: some View {
        JoinListView(listVM: listViewModel)
    }
}
