//
//  SHListCell.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-18.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation

class SHListCell: UICollectionViewCell{
    
    var cellImageView : UIImageView?
    var cellImage : UIImage?
    
    var address : String?
    var price : String?
    var brokerage : String?
    
    var mlsID : String?
    var bedroom = String()
    var bathroom = String()
    var lotArea : String?
    
    var location : CLLocationCoordinate2D?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setHouseView(){
        let selfFrame = self.frame
        cellImageView = UIImageView()
        let origin = CGPoint(x: houseCellEdge + 4, y: houseCellEdge + 2)
        let size = CGSize(width: selfFrame.width*0.3, height: selfFrame.width*0.3*3/4)
        cellImageView?.frame = CGRect(origin: origin, size: size)
        if cellImage != nil{
            cellImageView?.image = cellImage
        }else{
            cellImageView?.image  = UIImage(named: "default.png")
        }
        cellImageView?.contentMode = .ScaleAspectFill
        self.addSubview(cellImageView!)
        
        let unitHeight = ((cellImageView?.frame.size.height)! - 20)/5
        
        let addressLabel = UILabel()
        let priceLabel = UILabel()
        let brokerageLabel = UILabel()
        let mlsIDLabel = UILabel()
        let bedroomLabel = UILabel()
        let bathroomLabel = UILabel()
        let lotAreaLabel = UILabel()
        
        let addressX = cellImageView!.frame.maxX + 10
        let addressWidth = selfFrame.width - addressX - houseCellEdge*4
        addressLabel.frame = CGRect(x: addressX, y: houseCellEdge*2+5, width: addressWidth, height: unitHeight + 5)

        if self.address?.characters.count > 24{
            addressLabel.font = UIFont.boldSystemFontOfSize(10)
        }else{
            addressLabel.font = UIFont.boldSystemFontOfSize(15)
        }
        addressLabel.textColor = addressLabelColor
        addressLabel.text = self.address
        
        priceLabel.frame = CGRect(x: addressX, y: addressLabel.frame.maxY + 5,
                                  width: addressWidth, height: 2*unitHeight - 5)
        priceLabel.font = UIFont.boldSystemFontOfSize(18)
        priceLabel.textColor = priceLabelColor
        priceLabel.text = self.price
        
        brokerageLabel.frame = CGRect(x: addressX, y: priceLabel.frame.maxY + 5,
                                      width: addressWidth, height: unitHeight * 2)
        brokerageLabel.font = UIFont.boldSystemFontOfSize(12)
        brokerageLabel.adjustsFontSizeToFitWidth = true
        brokerageLabel.numberOfLines = 0
        brokerageLabel.textColor = brokerageLabelColor
        brokerageLabel.text = brokerage
        
        self.addSubview(addressLabel)
        self.addSubview(priceLabel)
        self.addSubview(brokerageLabel)
        
        let houseInfoX : CGFloat = houseCellEdge/2 - 2.5
        let houseInfoY = (cellImageView?.frame.maxY)! + 4
        let houseInfoHeight = self.frame.size.height - houseInfoY
        let unitWidth = (self.frame.maxX - houseCellEdge + 4)/4 - 3
        
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
        bedroomLabel.text = self.bedroom + " 房"
        
        bathroomLabel.frame = CGRect(x: bedroomLabel.frame.maxX + 1, y: houseInfoY,
                                     width: unitWidth - 10, height: houseInfoHeight)
        bathroomLabel.backgroundColor = labelBgColor
        bathroomLabel.textAlignment = .Center
        bathroomLabel.font = UIFont.boldSystemFontOfSize(14)
        bathroomLabel.textColor = labelTextColor
        bathroomLabel.text = self.bathroom + " 卫"
        
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
    
    func addressFont(string: String){
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}