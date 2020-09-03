//
//  ListControllerTests.swift
//  Shared Shopping ListTests
//
//  Created by Greg Hughes on 9/2/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import XCTest
@testable import Shared_Shopping_List
class ListControllerTests: XCTestCase {

    var list : List = ListController.createList(title: "createListTest1", listMasterID: "createListTest1", uuid: "createListTest1")
    var user = UserController.createUser(name: "testUser1", email: "testUser1@email.com", uuid: "testUser1ID")
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        ListController.BackEnd.shared.createList(list: list) { (list) in
            XCTAssertTrue(list.title == "createListTest1")
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBackEndCreate() {
        let list2 = ListController.createList(title: "createListTest2", listMasterID: user.uuid, uuid: "createListTest2")
        ListController.BackEnd.shared.createList(list: list) { (list) in
            XCTAssertTrue(list.title == "createListTest1")
        }
        ListController.BackEnd.shared.getListsWithUser(user: user) { (list) in
            XCTAssertTrue(list?[0].title == "createListTest1")
        }
    }

}
