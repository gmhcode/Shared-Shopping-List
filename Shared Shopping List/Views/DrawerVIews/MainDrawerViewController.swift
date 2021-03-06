//
//  MainDrawerViewController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/1/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import NotificationCenter


class MainDrawerViewController: UIViewController{

    @IBOutlet weak var topLeftButton: DrawerButton!
    @IBOutlet weak var topRightButton: DrawerButton!
    @IBOutlet weak var middleLeftButton: DrawerButton!
    @IBOutlet weak var middleRIghtButton: DrawerButton!
    @IBOutlet weak var bottomLeftButton: DrawerButton!
    @IBOutlet weak var bottomRightButton: DrawerButton!
    
    @IBOutlet weak var arrowButton : ShoppingButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationController.addObserver(selfClass: self, selector: #selector(userNotification(n:)), name:.user)
        
        NotificationController.addObserver(selfClass: self, selector: #selector(listNotification(n:)), name:.list)
        
        NotificationController.addObserver(selfClass: self, selector: #selector(itemNotification(n:)), name:.item)

    }

    @IBAction func arrowButtonTapped(_ sender: Any) {
    }

    @IBAction func testingVCButtonTapped(_ sender: Any) {
        if MainRootViewController.mainRootVC?.visibleViewController is TestingVC {
            return
        }
        MainRootViewController.mainRootVC?.performSegue(withIdentifier: "toTestingVC", sender: self)
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        
        NotificationController.post(name: .list, userInfo: ["list": ListController.createList(title: "TestList1", listMasterID: UserController.currentUser!.uuid, uuid: "12345")])
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        ListViewModel()
//        NotificationController.post(name: .user, userInfo: ["user": UserController.currentUser!])
        
    }
    
    @objc func listNotification(n:Notification){
        topLeftButton.setTitle("createList", for: .normal)
        topRightButton.setTitle("deleteList", for: .normal)
        middleLeftButton.setTitle("updateList", for: .normal)
        middleRIghtButton.setTitle("getList", for: .normal)
        let list = n.userInfo?["list"] as? SList
//        print(list!.title)
        
    }
    
    @objc func userNotification(n:Notification) {
        topLeftButton.setTitle("createUser", for: .normal)
        topRightButton.setTitle("deleteUser", for: .normal)
        middleLeftButton.setTitle("updateUser", for: .normal)
        middleRIghtButton.setTitle("getUser", for: .normal)
        let user = n.userInfo?["user"] as? User
//        print(user!.name)

    }
    
    @objc func itemNotification(n:Notification) {
        topLeftButton.setTitle("createItem", for: .normal)
        topRightButton.setTitle("deleteItem", for: .normal)
        middleLeftButton.setTitle("updateItem", for: .normal)
        middleRIghtButton.setTitle("getItem", for: .normal)
        let user = n.userInfo?["item"] as? Item
    }

}

