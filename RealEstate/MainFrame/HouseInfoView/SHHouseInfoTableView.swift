//
//  SHSearchTableView.swift
//  RealEstate
//
//  Created by Shawn on 2016-03-30.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class SHHouseInfoTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    let house = testHouse
    var segmentControl : UISegmentedControl!
    var housePackageInfo = [String: [Info]]()
    
    init(frame: CGRect, style: UITableViewStyle, housePackageInfo: [String: [Info]]) {
        super.init(frame: frame, style: style)
        self.housePackageInfo = housePackageInfo
        self.delegate = self
        self.dataSource = self
        
        self.registerClass(SHBasicCell.self, forCellReuseIdentifier: "BasicCell")
        self.registerClass(SHSegmentControlCell.self, forCellReuseIdentifier: "SegmentControlCell")
        
        let items = ["概要","详细","房间"]
        segmentControl = UISegmentedControl(items: items)
        segmentControl.frame = CGRect(x: screenWidth/2 - 100, y: 0, width: 200, height: 40)
        segmentControl.tintColor = .blackColor()
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: "houseInfoReview:", forControlEvents: .ValueChanged)
        
    }
    
    func houseInfoReview(sender: UISegmentedControl){
        self.reloadData()
        switch sender.selectedSegmentIndex{
        case 0:
            break
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0{
            return (housePackageInfo["摘要"]?.count)! + 3
        }else if segmentControl.selectedSegmentIndex == 1{
            return (housePackageInfo["详细"]?.count)! + 3
        }else if segmentControl.selectedSegmentIndex == 2{
            return ((housePackageInfo["房间"]?.count)! + 3)
        }
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 150
        }
        let lastIndex = (housePackageInfo["摘要"]?.count)! + 1
        if segmentControl.selectedSegmentIndex == 0 && indexPath.row == lastIndex{
            return 100
        }
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = SHBasicCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "BasicCell")
            cell.frame.size = CGSize(width: screenWidth, height: 150)
            cell.address = house.address!
            cell.city = "Markham, Ontario, L3S4Z5"
            cell.price = house.price!
            cell.type = "独立屋"
            cell.mlsID = house.mlsID
            cell.bedroom = house.bedroom
            cell.bathroom = house.bathroom
            cell.lotArea = house.lotArea
            cell.setLabel()
            
            return cell
        }
        if indexPath.row == 1{
            let cell = SHSegmentControlCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "SegmentControlCell", segmentControl: segmentControl)
            return cell
            
        }else if tableView.numberOfRowsInSection(0) - 1 > indexPath.row{
            if segmentControl.selectedSegmentIndex == 0{
                let summary = housePackageInfo["摘要"]! as [Info]
                let cellInfo = summary[indexPath.row - 2]
                let cell = SHInfoCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "InfoCell", title: cellInfo.chineseTitle, detail: cellInfo.data)
                if indexPath.row == 2{
                    cell.titleLabel.textColor = infoCellColor
                    cell.titleLabel.font = UIFont.boldSystemFontOfSize(20)
                }
                return cell
            }else if segmentControl.selectedSegmentIndex == 1{
                let summary = housePackageInfo["详细"]! as [Info]
                let cellInfo = summary[indexPath.row - 2]
                let cell = SHInfoCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "InfoCell", title: cellInfo.chineseTitle, detail: cellInfo.data)
                if indexPath.row == 2{
                    cell.titleLabel.textColor = infoCellColor
                    cell.titleLabel.font = UIFont.boldSystemFontOfSize(20)
                }
                return cell

            }else if segmentControl.selectedSegmentIndex == 2{
                let summary = housePackageInfo["房间"]! as [Info]
                let cellInfo = summary[indexPath.row - 2]
                let cell = SHInfoCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "InfoCell", title: cellInfo.chineseTitle, detail: cellInfo.data)
                if indexPath.row == 2{
                    cell.titleLabel.textColor = infoCellColor
                    cell.titleLabel.font = UIFont.boldSystemFontOfSize(20)
                }
                return cell

            }
        }
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "")
        
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}