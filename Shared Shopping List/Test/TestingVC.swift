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
    @IBOutlet weak var itemTableView: UITableView!
    
    let viewModel = TestingVCViewModel()
    
    class TestingVCViewModel {
        
        static let shared = TestingVCViewModel()
        var vc : TestingVC?
        ///used as test user names
        var testUserCount = 0
        var testItemCount = 0
        var testListCount = 0
        
        var selectedUser : User?
        var selectedList : List?
        var selectedItem : Item?
        
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
        
        func fetchAllItems(completion:@escaping([Item]?)->()){
            ItemController.BackEnd.shared.callAllItems { (items) in
                completion(items)
            }
        }
        
        func fetchItems(for list: List, completion: @escaping()->()) {

        }
        
        func fetchUsers(for list: List, completion: @escaping([User]?)->()) {
            UserController.BackEnd.shared.getUsersWithList(list: list) { (users) in
                guard let users = users else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
//                self.users = users
                
                print("USERS: 🇸🇩",users)
                completion(users)
            }
        }
        
        func fetchLists(for user: User, completion: @escaping()->()) {
            ListController.BackEnd.shared.getListsWithUser(user: user) { (lists) in
                guard let lists = lists else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
                self.lists = lists
                print("LISTS: 🇸🇩",lists)
                completion()
            }
        }
        
        func fetchItems(for user: User, completion: @escaping()->()) {
            
        }
        
        
        func fetchList(for item: Item, completion: @escaping()->()) {
            
        }
        
        func createList(user: User) {
            let list = ListController.createList(title: "NewList1", listMasterID: user.uuid, uuid: String(Int.random(in: 1...1000)))
            
            ListController.BackEnd.shared.createList(list: list, completion: {
                
            })
        }
        
        func listSelected(state : TestState, list: List, completion: @escaping()->()) {
            switch state {
            case .userHeaderSelected:
                if selectedUser != nil {
                    fetchAllItems {items in
                        guard let items = items else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<");completion(); return}
                        self.items = items.filter({$0.userSentId == self.selectedUser?.uuid && $0.listID == list.uuid})
                        self.vc?.reloadAll()
                        completion()
                    }
                }
                
            case .listsHeaderSelected:
                
                fetchUsers(for: list) {users in
                    guard let users = users else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
                    self.users = users
                    self.vc?.reloadAll()
                    completion()
                }
                fetchItems(for: list) {
                    self.vc?.reloadAll()
                    completion()
                }
                
            case .itemsHeaderSelected:
                fetchUsers(for: list) {users in
                    guard let users = users else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

                    if self.selectedItem != nil {
                        self.users = users.filter({$0.uuid == self.selectedItem?.userSentId })
                    }
                }
                break
            case .none:
                break
            }
        }
        
        func loadTables(completion: @escaping ()->()) {
            fetchAllLists {
                print("AllLists 🇨🇭", self.lists as Any)
                
                self.fetchAllUsers {
                    print("AllUsers 🛳", self.users as Any)
                    
                    self.fetchAllItems { items in
                        guard let items = items else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

                        print("ALLItems 🇸🇰", self.items as Any)
                        self.items = items
                        self.vc?.reloadAll()
                        completion()
                    }
                }
            }
        }
    }
    
    
    var funcNames : [String] = ["createUser","updateUser","deleteAllUsers"]
    var state : TestState = .none {
        didSet {
            stateSelected(state: state)
            viewModel.loadTables {}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        userTableView.delegate = self
        userTableView.dataSource = self
        itemTableView.delegate = self
        itemTableView.dataSource = self
        viewModel.vc = self
        viewModel.loadTables {
            self.reloadAll()
        }
        
       
    }
    
    func reloadAll() {
        DispatchQueue.main.async {
            self.userTableView.reloadData()
            self.itemTableView.reloadData()
            self.listTableView.reloadData()
        }
        
    }
    
    @objc func userHeaderTapped(sender: UIButton) {
        state = .userHeaderSelected
    }
    
    @objc func listHeaderTapped(sender: UIButton) {
        state = .listsHeaderSelected
    }
    
    @objc func itemHeaderTapped(sender: UIButton) {
        state = .itemsHeaderSelected
    }
}


extension TestingVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerTitle = getHeader(tableView: tableView)
        return headerTitle
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerButton: UIButton = UIButton()
        let headerTitle = getHeader(tableView: tableView)
        let colors = headerColor(state: state, tableView: tableView)
        
        headerButton.setTitle(headerTitle, for: .normal)
        headerButton.setTitleColor(colors.0, for: .normal)
        headerButton.backgroundColor = colors.1
        
        if headerTitle == "Users" {
            headerButton.addTarget(self, action: #selector(userHeaderTapped), for: .touchUpInside)
        } else if headerTitle == "Lists" {
            headerButton.addTarget(self, action: #selector(listHeaderTapped), for: .touchUpInside)
        }else if headerTitle == "Items" {
            headerButton.addTarget(self, action: #selector(itemHeaderTapped), for: .touchUpInside)
        }
        
        let headerView: UIView = UIView()
        
        headerView.addSubview(headerButton)
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        headerButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        headerButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        headerButton.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        headerButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == listTableView {
            return viewModel.lists.count
        } else if tableView == userTableView {
            return viewModel.users.count
        } else if tableView == itemTableView {
            return viewModel.items.count
        }
        return 0
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
        } else if tableView == itemTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableCell", for: indexPath)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.text = viewModel.items[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case itemTableView:
            
            break
        case userTableView:
            viewModel.selectedUser = viewModel.users[indexPath.row]
            break
        case listTableView:
            viewModel.listSelected(state: state, list: viewModel.lists[indexPath.row]) {
                
            }
            break
        default:
            break
        }
    }
}

extension TestingVC {
    
    func getHeader(tableView : UITableView) -> String {
        if tableView == listTableView {
            return "Lists"
        } else if tableView == userTableView {
            return "Users"
        } else if tableView == itemTableView {
            return "Items"
        }
        return "Cant get TableVIew"
    }
    
    func stateSelected(state: TestState) {
        switch state {
        case .userHeaderSelected:
            NotificationController.post(name: .user, userInfo: [:])
            break
        case .listsHeaderSelected:
            NotificationController.post(name: .list, userInfo: [:])
            break
        case .itemsHeaderSelected:
            NotificationController.post(name: .item, userInfo: [:])
        case .none:
            break
        }
    }
    
    func headerColor(state: TestState, tableView: UITableView) -> (UIColor,UIColor) {
        switch (state,tableView) {
        case (.userHeaderSelected,userTableView):
            return (UIColor.black,UIColor.gray)
            
        case (.listsHeaderSelected, listTableView):
            return (UIColor.black,UIColor.white)
            
        case (.itemsHeaderSelected, itemTableView):
            return (UIColor.black,UIColor.white)
            
        default:
            break
        }
        return (UIColor.white, UIColor.black)
    }
    
    enum TestState {
        case userHeaderSelected
        case listsHeaderSelected
        case itemsHeaderSelected
        case none
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
