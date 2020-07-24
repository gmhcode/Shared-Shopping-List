//
//  TestingVC.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/21/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.


import UIKit

class TestingVC: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    var funcNames : [String] = ["createUser","updateUser","deleteAllUsers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        segmentChanged(self)
    }

    
    @IBAction func segmentChanged(_ sender: Any) {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            funcNames = ["createList","updateList","deleteList","joinList","deleteAllLists"]
        case 1:
            funcNames = ["createItem","updateItem","deleteItem","deleteAllLists"]
        case 2:
            funcNames = ["createUser","updateUser","deleteAllUsers"]
        default:
            funcNames = ["createListMember","updateListMemver","deleteListMember"]
        }
        tableView.reloadData()
    }
}


extension TestingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funcNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testTableCell", for: indexPath)
        cell.textLabel?.text = funcNames[indexPath.row]
        return cell
    }
}
