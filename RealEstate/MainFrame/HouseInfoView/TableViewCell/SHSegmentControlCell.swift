//
//  SHSegmentControlCell.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-25.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class SHSegmentControlCell : UITableViewCell{
    
    var segmentControl : UISegmentedControl!
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, segmentControl: UISegmentedControl) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(segmentControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}