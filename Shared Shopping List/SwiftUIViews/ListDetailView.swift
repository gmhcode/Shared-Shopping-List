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
        listDetailViewModel = ListDetailViewModel(listID: list.uuid)
    }
    
    
    var body: some View {
        VStack{
            ForEach(listDetailViewModel.items) { item in
                Text(item.name)
            }
        }
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let s = Listi(uuid: "GregID0", title: "Greg's list 0", listMasterID: "gregid")
        ListDetailView(list: s)
    }
}
