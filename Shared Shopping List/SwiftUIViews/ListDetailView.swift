//
//  ListDetailView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/5/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct ListDetailView: View {
    
    @ObservedObject var listDetailViewModel: ListDetailViewModel
    @State var addItem: Bool = false
    
    
    init(list: Listi) {
        listDetailViewModel = ListDetailViewModel(list: list)
    }
    
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        addItem.toggle()
                    }) {
                        Text("Add Item")
                    }
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Remove Item")
                    }
                    Spacer()
                }
                List {
                    ForEach(listDetailViewModel.contentDict.keys.sorted(by: >)) { key in
                        Section(header: Text(key)) {
                            ForEach(listDetailViewModel.contentDict[key] ?? []) { val in
                                Text(val.name)
                                
                            }
                        }
                    }
                }
            }
            if addItem {
                AddItemPopover(addItem: $addItem, listDetailViewModel: listDetailViewModel)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
            
        }
        
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        let ls = ListViewModel().lists[0]
        let s = Listi(uuid: "GregID0", title: "Greg's list 0", listMasterID: "gregid")
        ListDetailView(list: s)
    }
}
