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
        ListController.BackEnd.shared.deleteAllLists()
//        ListController.deleteAllLists()
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // MARK: - Back End Tests
    func testBackEndCreateGetDelete() {
        

        let theExpectation2 = expectation(description: "get")
        let theExpectation3 = expectation(description: "delete")
        let list2 = ListController.createList(title: "createListTest2", listMasterID: user.uuid, uuid: "createListTest2")

       
        
        
        
        
        let exp = expectation(description: "create list set up")
        
        ListController.BackEnd.shared.createList(list: list2) { (list) in
            exp.fulfill()
            XCTAssertTrue(list?.title == "createListTest2")
            
            ListController.BackEnd.shared.getListsWithUser(user: self.user) { (list) in
                XCTAssertTrue(list?[0].title == "createListTest2")
                theExpectation2.fulfill()
                
                ListController.BackEnd.shared.deleteList(list: list![0]) {
                    
                    ListController.BackEnd.shared.getListsWithUser(user: self.user) { (lists) in
                        if lists == nil {
                            XCTAssert(true)
                        } else {
                           XCTAssertFalse(lists!.contains(where: {$0.title == "createListTest2"}) )
                        }
                        theExpectation3.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 5) { (error) in
            ListController.BackEnd.shared.deleteAllLists()
        }
        

    }
    
    


    // MARK: - Front End Tests
    // Create List works
       func testCreateListFrontEnd() {
        ListController.createList(title: "testCreateList", listMasterID: user.uuid, uuid: "testCreateListUuid")
           let lists = ListController.getAllLists()
           XCTAssertTrue(lists.count > 0)
           lists.forEach { (list) in
               ListController.deleteList(id: list.uuid)
           }
       }
       // Test changeTitle func
       func testChangeListTitleFrontEnd() {

        let list = ListController.createList(title: "testChangeListTitle", listMasterID: user.uuid, uuid: "testChangeListTitleUuid")
           ListController.changeName(id: list.uuid, newTitle: "newListTitle")
           let newListWithTitle = ListController.getList(id: list.uuid)
           XCTAssertTrue(newListWithTitle?.title == "newListTitle")

       }

       // Delete List works
       func testDeleteListFrontEnd() {

        ListController.createList(title: "testList", listMasterID: user.uuid, uuid: "testDeleteListUuid")
           let lists = ListController.getAllLists()
           lists.forEach { (list) in
               ListController.deleteList(id: list.uuid)
           }
           let remainingLists = ListController.getAllLists()
           print(remainingLists)
           XCTAssertTrue(remainingLists.count == 0)

       }

       /// Test List Failure
       func testGetListFailureFrontEnd() {

           let list = ListController.getList(id: UUID().uuidString)
           XCTAssertFalse(list != nil)

       }

       ///Tests Get List
       func testGetListFrontEnd() {

        let list1 = ListController.createList(title: "testList", listMasterID: user.uuid, uuid: "testGetListUuid")
           let list = ListController.getList(id: list1.uuid)
           XCTAssertTrue(list1.uuid == list?.uuid)

       }
}
