//
//  DrawerContainerViewController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/1/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class DrawerContainerViewController: UIViewController {

    @IBOutlet weak var arrowButton: DrawerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func arrowButtonTapped(_ sender: Any) {
        arrowButton.rotate()
        UserController.BackEnd.callUsers()
        ListController.BackEnd.shared.getAllLists { (lists) in
            print("LISTS   ",lists)
        }
        ListController.BackEnd.shared.createList(list: ListController.shared.list!)
        
//        TestBackEndFuncs.callUsers()
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
