//
//  MainDrawerViewController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/1/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

@objc protocol DrawerVC {
    var arrowButton: ShoppingButton! { get }
    @objc func arrowButtonTapped(_ sender: Any)
}
extension DrawerVC {
    
}

class MainDrawerViewController: UIViewController, DrawerVC {

    
    @IBOutlet weak var arrowButton : ShoppingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func arrowButtonTapped(_ sender: Any) {
        self.arrowButton.rotate()
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

