//
//  SHBasicCell.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-25.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class SHBasicCell: UITableViewCell{
    
    var address: String?
    var city: String?
    var price : String?
    var type : String?
    var lotArea : String?
    var mlsID : String?
    var bedroom : String?
    var bathroom : String?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setLabel(){
        let unitHeight = (self.frame.size.height - 40)/5
        
        let addressLabel = UILabel()
        let cityLabel = UILabel()
        let priceLabel = UILabel()
        let typeLabel = UILabel()
        let mlsIDLabel = UILabel()
        let bedroomLabel = UILabel()
        let bathroomLabel = UILabel()
        let lotAreaLabel = UILabel()
        
        let addressX : CGFloat = 10.0
        let addressWidth = self.frame.size.width - houseCellEdge*2
        addressLabel.frame = CGRect(x: addressX, y: houseCellEdge, width: addressWidth, height: unitHeight+5)
        
        if self.address?.characters.count > 24{
            addressLabel.font = UIFont.boldSystemFontOfSize(15)
        }else{
            addressLabel.font = UIFont.boldSystemFontOfSize(20)
        }
        addressLabel.textColor = addressLabelColor
        addressLabel.text = self.address
        
        cityLabel.frame = CGRect(x: addressX, y: addressLabel.frame.maxY, width: addressWidth, height: unitHeight)
        cityLabel.font = UIFont.boldSystemFontOfSize(15)
        cityLabel.textColor = addressLabelColor
        cityLabel.text = city
        
        priceLabel.frame = CGRect(x: addressX, y: cityLabel.frame.maxY,
                                  width: addressWidth, height: unitHeight + 2)
        priceLabel.font = UIFont.boldSystemFontOfSize(22)
        priceLabel.textColor = priceLabelColor
        priceLabel.text = self.price
        
        typeLabel.frame = CGRect(x: addressX, y: priceLabel.frame.maxY,
                                      width: addressWidth, height: unitHeight)
        typeLabel.font = UIFont.boldSystemFontOfSize(12)
        typeLabel.adjustsFontSizeToFitWidth = true
        typeLabel.numberOfLines = 0
        typeLabel.textColor = brokerageLabelColor
        typeLabel.text = "房屋类型： " + type!
        
        self.addSubview(addressLabel)
        self.addSubview(cityLabel)
        self.addSubview(priceLabel)
        self.addSubview(typeLabel)
        
        let houseInfoX : CGFloat = houseCellEdge
        let houseInfoY = typeLabel.frame.maxY + 4
        let houseInfoHeight : CGFloat = 40.0
        let unitWidth = (self.frame.size.width - houseCellEdge*2 - 3)/4
        
        mlsIDLabel.frame = CGRect(x: houseInfoX, y: houseInfoY,
                                  width: unitWidth + 10, height: houseInfoHeight)
        mlsIDLabel.backgroundColor = labelBgColor
        mlsIDLabel.textAlignment = .Center
        mlsIDLabel.font = UIFont.boldSystemFontOfSize(10)
        mlsIDLabel.textColor = labelTextColor
        mlsIDLabel.text = self.mlsID
        
        bedroomLabel.frame = CGRect(x: mlsIDLabel.frame.maxX + 1, y: houseInfoY,
                                    width: unitWidth - 10, height: houseInfoHeight)
        bedroomLabel.backgroundColor = labelBgColor
        bedroomLabel.textAlignment = .Center
        bedroomLabel.font = UIFont.boldSystemFontOfSize(14)
        bedroomLabel.textColor = labelTextColor
        bedroomLabel.text = self.bedroom! + " 房"
        
        bathroomLabel.frame = CGRect(x: bedroomLabel.frame.maxX + 1, y: houseInfoY,
                                     width: unitWidth - 10, height: houseInfoHeight)
        bathroomLabel.backgroundColor = labelBgColor
        bathroomLabel.textAlignment = .Center
        bathroomLabel.font = UIFont.boldSystemFontOfSize(14)
        bathroomLabel.textColor = labelTextColor
        bathroomLabel.text = self.bathroom! + " 卫"
        
        lotAreaLabel.frame = CGRect(x: bathroomLabel.frame.maxX + 1, y: houseInfoY,
                                    width: unitWidth + 10, height: houseInfoHeight)
        lotAreaLabel.backgroundColor = labelBgColor
        lotAreaLabel.textAlignment = .Center
        lotAreaLabel.font = UIFont.boldSystemFontOfSize(10)
        lotAreaLabel.textColor = labelTextColor
        lotAreaLabel.text = lotArea
        
        self.addSubview(mlsIDLabel)
        self.addSubview(bedroomLabel)
        self.addSubview(bathroomLabel)
        self.addSubview(lotAreaLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}