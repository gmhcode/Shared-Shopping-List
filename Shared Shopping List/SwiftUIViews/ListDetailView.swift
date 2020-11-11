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
    
    init(list: Listi) {
        listDetailViewModel = ListDetailViewModel(list: list)
    }
    
    
    var body: some View {
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
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let s = Listi(uuid: "GregID0", title: "Greg's list 0", listMasterID: "  ")
        ListDetailView(list: s)
    }
}
