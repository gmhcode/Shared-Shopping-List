//
//  SwiftUIListDetailsViewController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/9/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import SwiftUI
class SwiftUIListDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomConstraint = (view.frame.height * 0.8) - view.frame.height
        
        let s = Listi(uuid: "GregID0", title: "Greg's list 0", listMasterID: "gregid")
        let hostingView = UIHostingController(rootView: ListDetailView(list: s))
        
        addChild(hostingView)
        view.addSubview(hostingView.view)
        
        
        hostingView.view.translatesAutoresizingMaskIntoConstraints = false
        hostingView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        hostingView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        hostingView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstraint).isActive = true

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
