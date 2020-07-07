//
//  testyViewController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class testyViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let theView = UIView()
        theView.backgroundColor = .green
        
        self.view.addSubview(theView)
               theView.translatesAutoresizingMaskIntoConstraints = false
               theView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        theView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
               theView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
               theView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
