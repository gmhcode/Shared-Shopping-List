//
//  LDAddRemoveButtons.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/19/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct LDAddRemoveButtons: View {
    @ObservedObject var listDetailViewModel: ListDetailViewModel
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                listDetailViewModel.removingItems = false
                listDetailViewModel.addItem.toggle()
            }) {
                Text("Add Item")
            }
            Spacer()
            Button(action: {
                listDetailViewModel.addItem = false
                listDetailViewModel.removingItems.toggle()
            }) {
                Text("Remove Items")
            }
            Spacer()
        }
    }
}

struct LDAddRemoveButtons_Previews: PreviewProvider {
    static var previews: some View {
        let s = CodableList(uuid: "GregID0", title: "Greg's list 0", listMasterID: "gregid")
        var listDetailViewModel = ListDetailViewModel(list: s)
        LDAddRemoveButtons(listDetailViewModel: listDetailViewModel)
    }
}
