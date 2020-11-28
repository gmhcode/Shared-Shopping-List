//
//  CreateDeleteListButtons.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/20/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct CreateDeleteListButtons: View {
    @ObservedObject var listVM : ListViewModel
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                listVM.showCreateListView.toggle()
            }) {
                Text("Create List")
            }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, lineWidth: 2)
            )
            Spacer()
            Button(action: {
                listVM.showDeleteListView.toggle()
            }) {
                Text("Delete List")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, lineWidth: 2)
            )
            Spacer()
        }
        
    }
}

struct CreateDeleteListButtons_Previews: PreviewProvider {
    static var previews: some View {
        CreateDeleteListButtons(listVM: ListViewModel())
    }
}
