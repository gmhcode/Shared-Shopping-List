//
//  MotherView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/5/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        switch viewRouter.currentView {
        case .view1:
            ContentView()
//            AddItemPopover()
        case .view2:
            ListDetailView(list: ListViewModel().lists[0])
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
