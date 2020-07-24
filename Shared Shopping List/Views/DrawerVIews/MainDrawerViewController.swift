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
        NotificationCenter.default.addObserver(self, selector: #selector(userNotification(n:)), name: Notification.Name.init("User"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(listNotification(n:)), name: Notification.Name.init("List"), object: nil)
        // Do any additional setup after loading the view.
    }

    @IBAction func arrowButtonTapped(_ sender: Any) {
        TestBackEndFuncs.callUsers()
    }

    @IBAction func testingVCButtonTapped(_ sender: Any) {
        MainRootViewController.mainRootVC?.performSegue(withIdentifier: "toTestingVC", sender: self)
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
//        NotificationCenter.default.post(name: Notification.Name.init("List"), object: nil)
        
        NotificationCenter.default.post(name: Notification.Name.init("List"), object: nil, userInfo: ["list":ListController.createList(title: "TestList1", listMaster: UserController.currentUser!)])
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {

        NotificationCenter.default.post(name: Notification.Name.init("User"), object: nil, userInfo: ["user":UserController.currentUser])
    }
    
    
    
    
    
    @objc func listNotification(n:Notification){
        topLeftButton.setTitle("createList", for: .normal)
        topRightButton.setTitle("deleteList", for: .normal)
        middleLeftButton.setTitle("updateList", for: .normal)
        middleRIghtButton.setTitle("getList", for: .normal)
        let list = n.userInfo?["list"] as? List
        print(list?.title)
        
    }
    @objc func userNotification(n:Notification) {
        topLeftButton.setTitle("createUser", for: .normal)
        topRightButton.setTitle("deleteUser", for: .normal)
        middleLeftButton.setTitle("updateUser", for: .normal)
        middleRIghtButton.setTitle("getUser", for: .normal)
        let user = n.userInfo?["user"] as? User
        print(user?.name)

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

