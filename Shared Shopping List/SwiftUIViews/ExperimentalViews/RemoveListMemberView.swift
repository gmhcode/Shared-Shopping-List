//
//  RemoveListMemberView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct RemoveListMemberView: View {
    @ObservedObject var listVM = listViewModel
    @State var listMembers = listViewModel.listAndItemsAndListMembers.listMembers.filter({$0.listID == listViewModel.mostRecentList?.uuid})
    var body: some View {
        List(listMembers) { list in
            Text("\(list.userName)")
        }
//        List(listVM.listAndItemsAndListMembers.listMembers.filter({$0.listID == listVM.mostRecentList?.uuid})) { list in
//            Text("\(list.userName)")
//        }
            
        
    }
}

struct RemoveListMemberView_Previews: PreviewProvider {
    static var previews: some View {
        RemoveListMemberView()
    }
}
