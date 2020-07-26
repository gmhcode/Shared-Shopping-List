//
//  NotificationController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/23/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import NotificationCenter

class NotificationController {
    
    static func addObserver(selfClass: Any, selector: Selector, name: ClassNames) {
        
        NotificationCenter.default.addObserver(selfClass, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: nil)
        
    }
    
    static func post(name: ClassNames, userInfo: [AnyHashable:Any]) {
        
        NotificationCenter.default.post(name: Notification.Name.init(name.rawValue), object: nil, userInfo: userInfo)
    }
    
    enum ClassNames : String {
        case list = "List"
        case user = "User"
    }
}
