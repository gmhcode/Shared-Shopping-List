//
//  ShoppingEditSwitches.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/17/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct ShoppingEditSwitches: View {
    
    @State var isShopping = true
    @State var isEditing = false
    
    var body: some View {
        VStack {
            VStack {
                CreateDeleteListButtons(listVM: listViewModel).padding()
                AddRemoveListMemberButtons(listVM: listViewModel)
//                Spacer()
//                VStack {
//                    Text("Go Shopping")
//                    Toggle(isOn: $isShopping) {
//
//                    }
//                    .labelsHidden()
//                }
//                Spacer()
//                VStack {
//                    Text("Edit List")
//                    Toggle(isOn: $isEditing) {
//
//                    }
//                    .labelsHidden()
//                }
//                Spacer()
            }
            Spacer()
        }
    }
}

struct ShoppingEditSwitches_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingEditSwitches()
    }
}
