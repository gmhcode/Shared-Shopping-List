//
//  SwiftUIListViewController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/2/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import SwiftUI
class SwiftUIListViewController: UIViewController {


    static var vc : SwiftUIListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftUIListViewController.vc = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let bottomConstraint = (view.frame.height * 0.8) - view.frame.height
        let hostingView = UIHostingController(rootView: MotherView().environmentObject(ViewRouter()))
        
        addChild(hostingView)
        view.addSubview(hostingView.view)
        
        
        hostingView.view.translatesAutoresizingMaskIntoConstraints = false
        hostingView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        hostingView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        hostingView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstraint).isActive = true
    }
    
    
    
    func navigateToListDetails(list: Listi) {
        navigationController?.pushViewController(SwiftUIListDetailsViewController(list: list), animated: true)
        
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
