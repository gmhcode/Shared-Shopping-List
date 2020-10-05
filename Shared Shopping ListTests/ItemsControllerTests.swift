//
//  ItemsControllerTests.swift
//  Shared Shopping ListTests
//
//  Created by Greg Hughes on 10/5/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import XCTest
@testable import Shared_Shopping_List
class ItemsControllerTests: XCTestCase {
    
    var list : List = ListController.createList(title: "createUserTest1", listMasterID: "createUserTest1", uuid: "createListTest1")
    var user = UserController.createUser(name: "createUserTest1", email: "createUserTest1@email.com", uuid: "createUserTest1")
    var item = ItemController.createItem(name: "createUserTest1", store: "createUserTest1", userSentID: "createUserTest1", listID: "createListTest1", uuid: "createUserTest1")
    
    func testGetItemsWithList() throws {
        let create1Expectation = expectation(description: "create1")
        let create2Expectation = expectation(description: "create2")
        
        
        for i in 0...20 {
            let item = ItemController.createItem(name: "item \(i)", store: "target", userSentID: "badUserId", listID: list.uuid, uuid: "item \(i)")
            ItemController.BackEnd.shared.createItem(item: item) { (item) in
                if item!.name.contains("20") {
                    create1Expectation.fulfill()
                }
            }
        }
        for i in 20...40 {
            let item = ItemController.createItem(name: "item \(i)", store: "target", userSentID: user.uuid, listID: "badListID", uuid: "item \(i)")
            ItemController.BackEnd.shared.createItem(item: item) { (item) in
                if item!.name.contains("40") {
                    create2Expectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 10) { (_) in

            let userExpectation = self.expectation(description: "user")
            let listExpectation = self.expectation(description: "list")
            
            ItemController.BackEnd.shared.getItemsWithUser(user: self.user) { (items) in
                for it in items ?? [] {
                    XCTAssertTrue(it.userSentId == self.user.uuid)
                    if it.name == items!.last!.name {
                        userExpectation.fulfill()
                        break
                    }
                }
            }
            
            
            ItemController.BackEnd.shared.getItemsWithList(list: self.list) { (items) in
                for it in items ?? [] {
                    XCTAssertTrue(it.listID == self.list.uuid)
                    
                    if it.name == items!.last!.name {
                        listExpectation.fulfill()
                    }
                }
            }
            self.wait(for: [userExpectation,listExpectation], timeout: 10)
        }
    }
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

