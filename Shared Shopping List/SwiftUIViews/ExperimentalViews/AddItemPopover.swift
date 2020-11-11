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
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Store")
                Spacer()
            }
            TextField("Enter Store Name (if any)", text: $storeName)
                .padding()
            HStack {
                Text("Item")
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
                // Fallback on earlier versions
                
            }
            
            
        }
    }
}

struct AddItemPopover_Previews: PreviewProvider {
    static var previews: some View {
        AddItemPopover()
    }
}
