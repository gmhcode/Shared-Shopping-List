//
//  AppDelegate.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 6/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import CoreData
//let mainUser = CodableUser(uuid: "gregid", name: "Greg", email: "greg@greg.com")
let mainUser = CodableUser(uuid: "jid", name: "J", email: "j@j.com")
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        
        UIButton.appearance().layer.borderWidth = 1
//        UIButton.appearance().layer.borderColor = ColorConstants.borderColor.cgColor
        //        self.layer.borderColor = ColorConstants.borderColor.cgColor
//        Deletes Local hello my name is gregory michael hughes
//        UserController.deleteAllUsers()
//        ListController.deleteAllLists()
//        ItemController.deleteAllItems()
//////
//////        //Deletes back End
//        let testClass = TestBackEndFuncs()
//        testClass.deleteAllDataFromDatabases {
////            //Creates front and backend
//
//            testClass.createTestData()
//            sleep(1)
//        }

        DrawerButton.appearance().tintColor = ColorConstants.secondaryColor
        
        
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

