//
//  AddItemPopover.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/10/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct AddItemPopover: View {
    
    @State var storeName : String = ""
    @State var itemName : String = ""
    @Binding var addItem : Bool
//    @State var list: Listi
    @ObservedObject var listDetailViewModel: ListDetailViewModel
    
    var body: some View {
            VStack {
                Text(listDetailViewModel.list.title)
                    .font(.title)
                    .padding(.bottom,10)
                HStack {
                    Text("Store")
                        .padding(.leading)
                    Spacer()
                }
                TextField("Enter Store Name (if any)", text: $storeName)
                    .padding()
                    .padding(.bottom,30)
                
                HStack {
                    Text("Item")
                        .padding(.leading)
                    Spacer()
                }
                if #available(iOS 14.0, *) {
                    TextField("Enter Item Name", text: $itemName)
                        .padding()
                        .onChange(of: itemName, perform: { value in
                            print(itemName)
                        })
                } else {
                    TextField("Enter Item Name", text: $itemName)
                        .padding()
                }
                Button(action: {
                    listDetailViewModel.writeItem(name: itemName, store: storeName, userSentID: mainUser.uuid, listID: listDetailViewModel.list.uuid, uuid: "") {_ in
                        
                    }
                    
                    addItem.toggle()
                    
                    
                    
                }, label: {
                    HStack {
                        Text("Add Item")
                            .padding(20)
                        
                    }
                }).overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(.top,20)
                
            }
    }
}

struct AddItemPopover_Previews: PreviewProvider {
    static var previews: some View {
        let s = Listi(uuid: "GregID0", title: "Greg's list 0", listMasterID: "gregid")
        
        AddItemPopover(addItem: .constant(false), listDetailViewModel: ListDetailViewModel(list: s))
    }
}
