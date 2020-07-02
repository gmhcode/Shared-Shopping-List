//
//  RotatableView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 7/1/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

protocol ShoppingColors : UIView {
    
}


protocol Rotatable : UIView {
    var isPointingUp : Bool {get set}
}
extension Rotatable {
    
    func rotate() {
        if isPointingUp == true {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }) { (succeed) -> Void in
                self.isPointingUp = false
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            }) { (succeed) -> Void in
                self.isPointingUp = true
            }
        }
    }
}
class ShoppingButton: UIButton, Rotatable {
    var isPointingUp: Bool = true

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
