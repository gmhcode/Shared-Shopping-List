//
//  UserControllerTests.swift
//  Shared Shopping ListTests
//
//  Created by Greg Hughes on 9/7/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import XCTest
@testable import Shared_Shopping_List
class UserControllerTests: XCTestCase {

    var list : SList = ListController.createList(title: "createUserTest1", listMasterID: "createUserTest1", uuid: "createUserTest1")
    var user = UserController.createUser(name: "createUserTest1", email: "createUserTest1@email.com", uuid: "createUserTest1")
    var item = ItemController.createItem(name: "createUserTest1", store: "createUserTest1", userSentID: "createUserTest1", listID: "createUserTest1", uuid: "createUserTest1")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateGetDeleteUser() {
        
        let theExpectation1 = expectation(description: "create user")
        let theExpectation2 = expectation(description: "get")
        let theExpectation3 = expectation(description: "get3")
        let theExpectation4 = expectation(description: "get1")
        let theExpectation5 = expectation(description: "get2")
        
        UserController.BackEnd.shared.createUser(user: user) { (user) in
            print("🇪🇸", user as Any)
            XCTAssertTrue(user?.name == "createUserTest1")
            theExpectation1.fulfill()
            ListController.BackEnd.shared.createList(list: self.list) { (list) in
                theExpectation2.fulfill()
                UserController.BackEnd.shared.getUsersWithList(list: self.list) { (users) in
                    theExpectation3.fulfill()
                    UserController.BackEnd.shared.deleteUser(user: self.user) { (users) in
                        theExpectation4.fulfill()
                        UserController.BackEnd.shared.getUsersWithList(list: self.list) { (user) in
                            XCTAssertFalse(user?[0].name == "createUserTest1")
                            theExpectation5.fulfill()
                        }
                    }
                }
            }
        }
        
//        UserController.BackEnd.shared.createUser(user: user) { (user) in
//            guard let user = user else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); XCTFail(); return}
//            XCTAssertTrue(user.name == "createUserTest1")
//            theExpectation1.fulfill()

//            ListController.BackEnd.shared.createList(list: self.list) { (list) in
//                UserController.BackEnd.shared.getUsersWithList(list: self.list) { (users) in
//                    XCTAssertTrue(users?[0].name == "createUserTest1")
//                    theExpectation2.fulfill()
//
//
//                    UserController.BackEnd.shared.deleteUser(user: user) { (users) in
//                        UserController.BackEnd.shared.getUsersWithList(list: self.list) { (users) in
//                            XCTAssertTrue(users == nil)
//                            theExpectation4.fulfill()
//                        }
//                    }
//                }
//            }
//        }
//        let list2 = ListController.createList(title: "createListTest2", listMasterID: user.uuid, uuid: "createListTest2")
//        ListController.BackEnd.shared.createList(list: list2) { (list) in
//            theExpectation1.fulfill()
//            XCTAssertTrue(list?.title == "createListTest2")
//
//            ListController.BackEnd.shared.getListsWithUser(user: self.user) { (list) in
//                XCTAssertTrue(list?[0].title == "createListTest2")
//                theExpectation2.fulfill()
//
//                ListController.BackEnd.shared.deleteList(list: list![0]) {
//
//                    ListController.BackEnd.shared.getListsWithUser(user: self.user) { (lists) in
//                        if lists == nil {
//                            XCTAssert(true)
//                        } else {
//                            XCTAssertFalse(lists!.contains(where: {$0.title == "createListTest2"}) )
//                        }
//                        theExpectation3.fulfill()
//                    }
//                }
//            }
//        }
        waitForExpectations(timeout: 10) { (error) in
            
        }
    }
    override class func tearDown() {
        super.tearDown()
        UserController.BackEnd.shared.deleteAllUsers()
        ListController.BackEnd.shared.deleteAllLists()
    }
}
