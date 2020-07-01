//
//  SectionHeaderView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 6/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var sectionHeaderTitle: UILabel!
    
    var listType : String? {
        didSet {
            sectionHeaderTitle.text = listType ?? ""
        }
    }
}
