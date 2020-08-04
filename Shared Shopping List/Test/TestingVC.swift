//
//  TestingVC.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/21/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.


import UIKit

class TestingVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var userTableView: UITableView!
    
    let viewModel = TestingVCViewModel()
    
    class TestingVCViewModel {
        
        static let shared = TestingVCViewModel()
        ///used as test user names
        var testUserCount = 0
        var testItemCount = 0
        var testListCount = 0
        
        var selectedUser : User?
        var selectedList : List?
        var selectedItem : User?
        
        var users : [User] = []
        var lists : [List] = []
        var items : [Item] = []
        
        
        func fetchAllUsers(completion:@escaping()->()) {
            UserController.BackEnd.shared.callAllUsers { (users) in
                guard let users = users else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

                self.users = users
                completion()
            }
        }
        
        func fetchAllLists(completion:@escaping()->()) {
            ListController.BackEnd.shared.callAllLists { (lists) in
                guard let lists = lists else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

                self.lists = lists
                completion()
            }
        }
        
        func fetchAllItems(completion:@escaping()->()){
            ItemController.BackEnd.shared.callAllItems { (items) in
                guard let items = items else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

                self.items = items
                completion()
            }
        }
        
        func createList(user: User) {
            let list = ListController.createList(title: "NewList1", listMasterID: user.uuid, uuid: String(Int.random(in: 1...1000)))
                                                 
            ListController.BackEnd.shared.createList(list: list)
        }
        
    }
    
    
    var funcNames : [String] = ["createUser","updateUser","deleteAllUsers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        userTableView.delegate = self
        userTableView.dataSource = self
        
        viewModel.fetchAllLists { [weak self] in
            print("AllLists 🇨🇭", self?.viewModel.users as Any)
            DispatchQueue.main.async {
                self?.listTableView.reloadData()
            }
        }
        
        viewModel.fetchAllUsers { [weak self] in
            print("AllUsers 🛳", self?.viewModel.users as Any)
            DispatchQueue.main.async {
                self?.userTableView.reloadData()
            }
        }
        
        viewModel.fetchAllItems { [weak self] in
            print("ALLItems 🇸🇰", self?.viewModel.items as Any)
        }
    }
}


extension TestingVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = getHeader(tableView: tableView)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == listTableView {
            return viewModel.lists.count
        } else {
            return viewModel.users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == listTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listTableCell", for: indexPath)
            cell.textLabel?.text = viewModel.lists[indexPath.row].title
            return cell
        } else if tableView == userTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userTableCell", for: indexPath)
            cell.textLabel?.text = viewModel.users[indexPath.row].name
            return cell
        }
        
        return UITableViewCell()
    }
    
    func getHeader(tableView : UITableView) -> String {
        if tableView == listTableView {
            return "Lists"
        } else if tableView == userTableView {
            return "Users"
        }
        return "Cant get TableVIew"
    }
    
}

//extension TestingVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return funcNames.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "testTableCell", for: indexPath)
//        cell.textLabel?.text = funcNames[indexPath.row]
//        return cell
//    }
//}
