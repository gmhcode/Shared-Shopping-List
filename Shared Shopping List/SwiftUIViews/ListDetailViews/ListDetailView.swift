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
    
    
    init(list: CodableList) {
        listDetailViewModel = ListDetailViewModel(list: list)
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                Text(listViewModel.mostRecentList?.title ?? "  ")
                LDAddRemoveButtons(listDetailViewModel: listDetailViewModel)
                List {
                    ForEach(listDetailViewModel.contentDict.keys.sorted(by: >)) { key in
                        Section(header: Text(key)) {
                            if listDetailViewModel.removingItems {
                                ForEach(listDetailViewModel.contentDict[key] ?? []) { val in
                                    HStack {
                                        Text(val.name)
                                        Spacer()
                                        Button(action: {
                                            listDetailViewModel.deleteItem(item: val)
                                        }) {
                                            Text("Remove").padding()
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.red, lineWidth: 2)
                                                )
                                        }.padding()
                                    }
                                }.overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                            } else {
                                ForEach(listDetailViewModel.contentDict[key] ?? []) { val in
                                    
                                    ItemCell(item: val)
                                    
                                }
                            }
                        }
                    }
                }
            }
            if listDetailViewModel.addItem {
                AddItemPopover(listDetailViewModel: listDetailViewModel)
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
        let s = CodableList(uuid: "GregID0", title: "Greg's list 0", listMasterID: "gregid")
        ListDetailView(list: s)
    }
}
