//
//  MainCollectionViewCell.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 6/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var shoppingListTitleLabel: UILabel!
    
    var shoppingListTitle : String? {
        didSet {
            shoppingListTitleLabel.text = shoppingListTitle
        }
    }
    
}
