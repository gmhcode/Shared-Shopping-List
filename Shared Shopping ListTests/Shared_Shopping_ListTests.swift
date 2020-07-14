//
//  Shared_Shopping_ListTests.swift
//  Shared Shopping ListTests
//
//  Created by Greg Hughes on 6/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import XCTest
@testable import Shared_Shopping_List

class Shared_Shopping_ListTests: XCTestCase {
    let user = UserController.createUser(name: "testUserName", email: "@.com")
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Create List works
    func testCreateList() throws {
        ListController.createList(title: "testList", listMaster: user)
        let lists = ListController.getAllLists()
        XCTAssertTrue(lists.count > 0)
        lists.forEach { (list) in
            ListController.deleteList(id: list.id)
        }
    }
    //Test changeTitle func
    func testChangeListTitle() {
        let list = ListController.createList(title: "testList", listMaster: user)
        ListController.changeName(id: list.id, newTitle: "newListTitle")
        let newListWithTitle = ListController.getList(id: list.id)
        XCTAssertTrue(newListWithTitle?.title == "newListTitle")
    }
    
    //Delete List works
    func testDeleteList() {
        ListController.createList(title: "testList", listMaster: user)
        let lists = ListController.getAllLists()
        lists.forEach { (list) in
            ListController.deleteList(id: list.id)
        }
        let remainingLists = ListController.getAllLists()
        print(remainingLists)
        XCTAssertTrue(remainingLists.count == 0)
    }
    
    func testGetListFailure() {
        let list = ListController.getList(id: UUID())
        XCTAssertFalse(list != nil)
        
    }
    
    func testGetList(){
        let list1 = ListController.createList(title: "testList", listMaster: user)
        let list = ListController.getList(id: list1.id)
        XCTAssertTrue(list1.id == list?.id)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
