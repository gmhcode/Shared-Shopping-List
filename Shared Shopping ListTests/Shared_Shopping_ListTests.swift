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
    func testCreateList() {
        ListController.createList(title: "testList", listMaster: user)
        let lists = ListController.getAllLists()
        XCTAssertTrue(lists.count > 0)
        lists.forEach { (list) in
            ListController.deleteList(id: list.uuid)
        }
    }
    // Test changeTitle func
    func testChangeListTitle() {
        
        let list = ListController.createList(title: "testList", listMaster: user)
        ListController.changeName(id: list.uuid, newTitle: "newListTitle")
        let newListWithTitle = ListController.getList(id: list.uuid)
        XCTAssertTrue(newListWithTitle?.title == "newListTitle")
        
    }
    
    // Delete List works
    func testDeleteList() {
        
        ListController.createList(title: "testList", listMaster: user)
        let lists = ListController.getAllLists()
        lists.forEach { (list) in
            ListController.deleteList(id: list.uuid)
        }
        let remainingLists = ListController.getAllLists()
        print(remainingLists)
        XCTAssertTrue(remainingLists.count == 0)
        
    }
    
    /// Test List Failure
    func testGetListFailure() {
        
        let list = ListController.getList(id: UUID().uuidString)
        XCTAssertFalse(list != nil)
        
    }
    
    ///Tests Get List
    func testGetList() {
        
        let list1 = ListController.createList(title: "testList", listMaster: user)
        let list = ListController.getList(id: list1.uuid)
        XCTAssertTrue(list1.uuid == list?.uuid)
        
    }
    
    ///Test Create Item
    func testCreateItem() {
        
        let user = UserController.createUser(name: "testUser1", email: "testEmail1")
        let item = ItemController.createItem(name: "testItem1", store: "testStore1", userSent: user, list: ListController.createList(title: "testList1", listMaster: user))
        XCTAssertTrue(ItemController.getItem(id: item.uuid)?.uuid == item.uuid)
        ItemController.deleteAllItems()
        
    }
    
    ///Test Change Item
    func testChangeItem() {
        
        let user = UserController.createUser(name: "testUser1", email: "testEmail1")
        let item = ItemController.createItem(name: "testItem1", store: "testStore1", userSent: user, list: ListController.createList(title: "testList1", listMaster: user))
        ItemController.changeName(id: item.uuid, newName: "newItemNameTest1")
        XCTAssertTrue(ItemController.getItem(id: item.uuid)?.name == "newItemNameTest1")
        ItemController.deleteAllItems()
        
    }
    
    ///Test DeleteItem
    func testDeleteItem() {
        
        let user = UserController.createUser(name: "testUser1", email: "testEmail1")
        let item = ItemController.createItem(name: "testItem1", store: "testStore1", userSent: user, list: ListController.createList(title: "testList1", listMaster: user))
        ItemController.deleteItem(id: item.uuid)
        XCTAssertTrue(ItemController.getAllItem() == [])
        ItemController.deleteAllItems()
        
    }
    
    ///Test Get Item Failure
    func testGetItemFailure() {
        XCTAssertTrue(ItemController.getItem(id: UUID().uuidString) == nil)
    }
    
    ///Test Get Item
    func testGetItem() {
        
        let user = UserController.createUser(name: "testUser1", email: "testEmail1")
        let item = ItemController.createItem(name: "testItem1", store: "testStore1", userSent: user, list: ListController.createList(title: "testList1", listMaster: user))
        XCTAssertTrue(ItemController.getItem(id: item.uuid)?.uuid == item.uuid)
        ItemController.deleteAllItems()
        
    }
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
