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
    
    
    var funcNames : [String] = ["createUser","updateUser","deleteAllUsers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        userTableView.delegate = self
        userTableView.dataSource = self
       
    }

    
//    @IBAction func segmentChanged(_ sender: Any) {
//
//        switch segmentControl.selectedSegmentIndex {
//        case 0:
//            funcNames = ["createList","updateList","deleteList","joinList","deleteAllLists"]
//        case 1:
//            funcNames = ["createItem","updateItem","deleteItem","deleteAllLists"]
//        case 2:
//            funcNames = ["createUser","updateUser","deleteAllUsers"]
//        default:
//            funcNames = ["createListMember","updateListMemver","deleteListMember"]
//        }
//        tableView.reloadData()
//    }
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
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
