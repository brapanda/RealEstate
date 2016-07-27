//
//  SHImageScrollView.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-20.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation

class SHScrollView : UIView, UITableViewDelegate{
    
    var imageList : [String]!
    var houseLocation: CLLocationCoordinate2D!
    var cycleScrollView : WXCycleScrollView?
    var scrollView : UIScrollView!
    var tableView : SHHouseInfoTableView!
    
    var testInfo = [Info]()
    var testInfo2 = [Info]()
    var testInfo3 = [Info]()
    
    var package = [String: [Info]]()
    
    let origin = CGPointZero
    let size = CGSize(width: screenWidth, height: 200)
    let topViewHeight = screenWidth*3/4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: CGRect(origin: origin, size: self.frame.size))
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight*2)
        
        tableView = SHHouseInfoTableView(frame: CGRect(x: 0,y:0,width: screenWidth,height: screenHeight), style: UITableViewStyle.Plain,housePackageInfo: package)
        
        tableView.separatorColor = .whiteColor()
        tableView.allowsSelection = false
        
        
        
        
        testInfo.append(Info(title: "summary", data: ""))
        for i in 1...15{
            testInfo.append(Info(title: String(i), data: String(i)))
        }
        
        testInfo2.append(Info(title: "Property Info", data: ""))
        for i in 1...20{
            testInfo2.append(Info(title: String(i), data: String(i)))
        }
        
        testInfo3.append(Info(title: "Inside", data: ""))
        for i in 1...7{
            testInfo3.append(Info(title: String(i), data: String(i)))
        }
        
        package = ["摘要":testInfo,"详细": testInfo2, "房间": testInfo3]
        
        tableView.housePackageInfo = self.package
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(topViewHeight, 0, 0, 0)
        
        self.addSubview(tableView)

    }
    
    
    func setUpData(){
        self.cycleScrollView = WXCycleScrollView.init(frame: CGRect(origin: CGPointMake(0, -topViewHeight),size: CGSize(width: screenWidth, height: topViewHeight)),
                                                      imageNames: imageList)
        self.cycleScrollView?.autoScrollTimeInterval = 4
        self.cycleScrollView?.pageControl.currentPageIndicatorTintColor = navigationColor
        
        self.tableView.addSubview(cycleScrollView!)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.isKindOfClass(SHHouseInfoTableView){
            let SHT = tableView as! SHHouseInfoTableView
            if indexPath.row == 0{
                return 150
            }
            let lastIndex = (SHT.housePackageInfo["摘要"]?.count)! + 1
            if SHT.segmentControl.selectedSegmentIndex == 0 && indexPath.row == lastIndex{
            return 100
            }
        }
        return 40
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        if scrollView.isKindOfClass(SHHouseInfoTableView){
            if offY < -topViewHeight{
                if cycleScrollView != nil{
                    let frame = CGRectMake(0, offY, screenWidth, -offY)
                    self.cycleScrollView!.frame.origin.y = offY
                    self.cycleScrollView?.frame.size.height = -offY
                    self.cycleScrollView?.SetFrame(offY)
                    let imageViewList = cycleScrollView?.scrollView.subviews
                    let offX = cycleScrollView?.scrollView.contentOffset.x
                    let imageView = imageViewList![Int(offX!/screenWidth)] as! UIImageView
                    imageView.frame.size.height = -offY
                    imageView.frame.size.width = -offY*4/3
                    imageView.frame.origin.x = offX! - (-offY*4/3 - screenWidth)/2
                }
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
