//
//  AddRemoveListMemberButtons.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/25/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct AddRemoveListMemberButtons: View {
    @ObservedObject var listVM : ListViewModel
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                listVM.addListMemberView.toggle()
            }) {
                Text("Add Member")
            }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, lineWidth: 2)
            )
            Spacer()
            Button(action: {
                listVM.removeListMemberView.toggle()
            }) {
                Text("Remove Member")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, lineWidth: 2)
            )
            Spacer()
        }
    }
}

struct AddRemoveListMemberButtons_Previews: PreviewProvider {
    static var previews: some View {
        
        AddRemoveListMemberButtons(listVM: listViewModel)
    }
}
