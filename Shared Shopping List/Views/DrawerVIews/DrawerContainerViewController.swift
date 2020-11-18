//
//  DrawerContainerViewController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/1/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class DrawerContainerViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var arrowButton: DrawerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func arrowButtonTapped(_ sender: Any) {
        arrowButton.rotate()

        
    }

}
