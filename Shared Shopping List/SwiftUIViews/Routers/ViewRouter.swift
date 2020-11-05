//
//  ViewRouter.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/5/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
class ViewRouter: ObservableObject {
    @Published var currentView : Page = .view1
}

enum Page {
    case view1
    case view2
}

