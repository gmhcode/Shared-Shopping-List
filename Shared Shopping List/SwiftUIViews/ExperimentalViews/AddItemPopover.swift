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
    @State var list: String = "List Name"
    
    var body: some View {
        VStack {
            Text(list)
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
            Spacer()
        }
    }
}

struct AddItemPopover_Previews: PreviewProvider {
    static var previews: some View {
        AddItemPopover()
    }
}
