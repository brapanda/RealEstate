//
//  SHInfoCell.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-25.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class SHInfoCell: UITableViewCell{
    
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,title: String, detail: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let width = screenWidth
        let height = self.frame.size.height
        
        titleLabel.frame = CGRect(x: 20, y: 0, width: width/2 - 10, height: height)
        titleLabel.font = UIFont.boldSystemFontOfSize(14)
        titleLabel.text = title
        
        detailLabel.frame = CGRect(x: titleLabel.frame.maxX, y: 0, width: width/2 - 10, height: height)
        detailLabel.font = UIFont.boldSystemFontOfSize(14)
        detailLabel.textColor = .grayColor()
        detailLabel.text = detail
        
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}