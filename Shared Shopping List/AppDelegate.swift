//
//  AppDelegate.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 6/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        TestFunctions()
        
//        let user = UserController.createUser(name: "greg", email: "greg@gmail.com", id: "1", groups: [])
//        UserController.currentUser = TestFunctions.users["Greg"]
//        UserController.shared.deleteUser(user: user)
//        UIButton.appearance().layer.borderWidth = 1
//        UIButton.appearance().layer.borderColor = ColorConstants.borderColor.cgColor
//        //        self.layer.borderColor = ColorConstants.borderColor.cgColor
        UserController.deleteAllUsers()
        ListController.deleteAllLists()
        ItemController.deleteAllItems()
        
        let testClass = TestBackEndFuncs()
        testClass.deleteAllDataFromDatabases {
            testClass.createTestData()
        }
        ListController.BackEnd.shared.callAllLists { (list) in
            print("🇬🇸 LISTS: ", list)
//            let lists = lists
            list?.forEach({print($0)})
        }
        
        
        
//        BackEndUtils.deleteWholeDatabase()
        
//        let user = UserController.createUser(name: "greg1", email: "greg@email", uuid: "1234")
//        UserController.BackEnd.shared.createUser(user: user, completion: {user in
//
//        })
//        ListController.BackEnd.shared.deleteAllLists()
        
        
        
//        UserController.currentUser = user
        DrawerButton.appearance().tintColor = ColorConstants.borderColor
//        UserController.BackEnd.shared.createUser(user: user)
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    

}

