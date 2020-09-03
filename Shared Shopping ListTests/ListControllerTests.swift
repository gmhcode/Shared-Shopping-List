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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBackEndCreate() {
        let list = ListController.createList(title: "createListTest1", listMasterID: "createListTest1", uuid: "createListTest1")
        ListController.BackEnd.shared.createList(list: list, completion: <#T##() -> ()#>)
    }

}
