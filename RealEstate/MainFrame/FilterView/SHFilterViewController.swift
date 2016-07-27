//
//  SHFilterViewController.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-14.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation

class SHFilterViewController: UIViewController, DOPDropDownMenuDataSource,DOPDropDownMenuDelegate{
    
    var multisectorControl = SAMultisectorControl()
    var menu = DOPDropDownMenu()
    var bedroomStart = UILabel()
    var bedroomEnd   = UILabel()
    var bathStart    = UILabel()
    var bathEnd      = UILabel()
    var priceStart   = UILabel()
    var priceEnd     = UILabel()
    var menuList     = [[String]]()
    var searchInfo   = houseSearchData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let area = ["城市(全部)","多伦多","烈治文山","万锦","密西沙加","皮克灵","士嘉堡","北约克","旺市","奥罗拉","新市场","怡陶碧谷"]
        let houseType = ["类型(全部)","独立屋","平房","镇屋","公寓"]
        let propertyType = ["产权(全部)","FreeHold","LeaseHold"]
        
        
        menuList = [area,houseType,propertyType]
        
        setBackButton()
        
        // set DopDropDownMenu
        menu = DOPDropDownMenu(origin: CGPoint(x: 0,y: 0), andHeight: 64)
        menu.indicatorColor = .redColor()
        menu.textColor = UIColor(red:26.0/255.0, green:26.0/255.0, blue:26.0/255.0, alpha:1.0)
        menu.dataSource = self
        menu.delegate = self
        menu.selectIndexPath(DOPIndexPath(col: 0, row: area.indexOf(searchInfo.city)!))
        menu.selectIndexPath(DOPIndexPath(col: 1, row: houseType.indexOf(searchInfo.type)!))
        menu.selectIndexPath(DOPIndexPath(col: 2, row: propertyType.indexOf(searchInfo.right)!))
        
        self.view.addSubview(menu)
        
        
        let origin = CGPoint(x: 0, y: 64)
        let size = CGSize(width: screenWidth, height: screenWidth)
        multisectorControl.frame = CGRect(origin: origin, size: size)
        //        multisectorControl.endColor = endCycleColor
        
        // set multisectorControl
        self.setupDesign()
        self.setupMultisectorControl()
        self.view.addSubview(multisectorControl)
        
        let label1 = labelDesign(startLabel: bedroomStart,
                                 endLabel: bedroomEnd,
                                 title: "厕所",
                                 toString: "-到-",
                                 titleColor: sector1Color)
        
        let label2 = labelDesign(startLabel: bathStart,
                                 endLabel: bathEnd,
                                 title: "房间",
                                 toString: "-到-",
                                 titleColor: sector2Color)
        
        let label3 = labelDesign(startLabel: priceStart,
                                 endLabel: priceEnd,
                                 title: "售价",
                                 toString: "-到-",
                                 titleColor: sector3Color)
        
        setLabels([label1,label2,label3])
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabels(labelList: [labelDesign]){
        let totalLabels = CGFloat(labelList.count)
        let startY =  menu.frame.size.height + multisectorControl.frame.size.height
        let totalHeight = screenHeight - startY - 60
        let labelHeight = totalHeight / 4
        let labelWidth = (screenWidth - totalLabels * 20)/3
        
        var index : CGFloat = 0
        for l in labelList{
            let originX : CGFloat = labelWidth * index + 20 * (index + 1)
            
            //title
            let labelTitle   = UILabel()
            let originTitle  = CGPoint(x: originX, y: startY)
            let sizeTitle    = CGSize(width: labelWidth, height: labelHeight)
            labelTitle.frame = CGRect(origin: originTitle, size: sizeTitle)
            labelTitle.font  = UIFont.boldSystemFontOfSize(30)
            labelTitle.textColor = l.titleColor
            labelTitle.text = l.title
            labelTitle.textAlignment = .Center
            
            //Start value
            let startLabel    = l.startLabel
            let originSL      = CGPoint(x: originX, y: startY + labelHeight)
            let sizeSL        = CGSize(width: labelWidth, height: labelHeight)
            startLabel!.frame = CGRect(origin: originSL, size: sizeSL)
            startLabel?.font  = UIFont.boldSystemFontOfSize(24)
            startLabel?.textColor = .whiteColor()
            startLabel?.textAlignment = .Center
            
            //to String
            let toLabel     = UILabel()
            let originTo    = CGPoint(x: originX, y: startY + labelHeight*2 - 10)
            let sizeTo      = CGSize(width: labelWidth, height: 30)
            toLabel.frame   = CGRect(origin: originTo, size: sizeTo)
            toLabel.font    = UIFont.systemFontOfSize(15)
            toLabel.textColor = .grayColor()
            toLabel.text = l.toString
            toLabel.textAlignment = .Center
            
            //End value
            let endLabel = l.endLabel
            let originEL = CGPoint(x: originX, y: startY + labelHeight*2 + 10)
            let sizeEL   = CGSize(width: labelWidth, height: labelHeight)
            endLabel?.frame = CGRect(origin: originEL, size: sizeEL)
            endLabel?.font  = UIFont.boldSystemFontOfSize(24)
            endLabel?.textColor = .whiteColor()
            endLabel?.textAlignment = .Center
            
            self.view.addSubview(labelTitle)
            self.view.addSubview(startLabel!)
            self.view.addSubview(toLabel)
            self.view.addSubview(endLabel!)
            
            index++
        }
        
    }
    
    func setBackButton(){
        let buttonWidth : CGFloat = 100
        let buttonHeight : CGFloat = 40
        let distanceBetweenTwoButton : CGFloat = 30
        let aboveScreen : CGFloat = 10
        let edgeX = (screenWidth - 2*buttonWidth - distanceBetweenTwoButton)/2
        let edgeY = screenHeight - aboveScreen - buttonHeight
        
        let backButton = UIButton(type: .Custom)
        let cancelButton = UIButton(type: .Custom)
        
        backButton.frame = CGRect(x: edgeX, y: edgeY, width: buttonWidth, height: buttonHeight)
        cancelButton.frame = CGRect(x: (screenWidth - edgeX - buttonWidth),
                                    y: edgeY, width: buttonWidth, height: buttonHeight)
        
        backButton.backgroundColor = navigationColor
        cancelButton.backgroundColor = navigationColor
        
        backButton.layer.cornerRadius = 5.0
        cancelButton.layer.cornerRadius = 5.0
        
        backButton.setTitle("Search", forState: .Normal)
        backButton.setTitleColor(.whiteColor(), forState: .Normal)
        
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.setTitleColor(.whiteColor(), forState: .Normal)
        
        
        backButton.addTarget(self, action: "searchHouse", forControlEvents: .TouchUpInside)
        cancelButton.addTarget(self, action: "goBackToMap", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(backButton)
        self.view.addSubview(cancelButton)
    }
    
    func searchHouse(){
        searchHouseInfo = searchInfo
        self.dismissViewControllerAnimated(true, completion: {self.printData(searchHouseInfo)})
    }
    
    func printData(info: houseSearchData){
        print("city: \(info.city)")
        print("type: \(info.type)")
        print("right: \(info.right)")
        print("beds: \(info.bedroomBegin)")
        print("bede: \(info.bedroomEnd)")
        print("baths: \(info.bathroomBegin)")
        print("bathe: \(info.bathroomEnd)")
        print("prices: \(info.priceBegin)")
        print("pricee: \(info.priceEnd)")
    }
    
    func goBackToMap(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupDesign(){
        self.view.backgroundColor = filterViewColor
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage()
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    func setupMultisectorControl(){
        self.multisectorControl.addTarget(self, action: "multisectorValueChanged:", forControlEvents: .ValueChanged)
        
        let redColor   = sector1Color
        let blueColor  = sector2Color
        let greenColor = sector3Color
        
        var sector1 = SAMultisectorSector(color: redColor, maxValue: 5)
        var sector2 = SAMultisectorSector(color: blueColor, maxValue: 5)
        var sector3 = SAMultisectorSector(color: greenColor, maxValue: 500)
        
        sector1.tag = 0
        sector2.tag = 1
        sector3.tag = 2
        
        sector1.startValue = Double(searchHouseInfo.bedroomBegin)
        sector1.endValue   = Double(searchHouseInfo.bedroomEnd)
        
        sector2.startValue = Double(searchHouseInfo.bathroomBegin)
        sector2.endValue   = Double(searchHouseInfo.bathroomEnd)
        
        sector3.startValue = Double(searchHouseInfo.priceBegin)
        sector3.endValue   = Double(searchHouseInfo.priceEnd)
        
        
        
        self.multisectorControl.addSector(sector1)
        self.multisectorControl.addSector(sector2)
        self.multisectorControl.addSector(sector3)
        self.updateDataView()
    }
    
    func multisectorValueChanged(sender: AnyObject){
        self.updateDataView()
    }
    
    func updateDataView(){
        for sector in self.multisectorControl.sectors {
            let startValue : NSString = "\(sector.startValue)"
            let endValue : NSString = "\(sector.endValue) +"
            
            print("start : \(lround(sector.startValue)), end : \(lround(sector.endValue))")
            
            if sector.tag == 0{
                let bedroomS = lround(sector.startValue)
                let bedroomE = lround(sector.endValue)
                searchInfo.bedroomBegin = bedroomS
                searchInfo.bedroomEnd = bedroomE
                bedroomStart.text = String(bedroomS)
                if sector.endValue == sector.maxValue{
                    
                    bedroomEnd.text = String(bedroomE) + "+"
                }else{
                    bedroomEnd.text = String(bedroomE)
                }
            }
            if sector.tag == 1{
                let bathroomS = lround(sector.startValue)
                let bathroomE = lround(sector.endValue)
                searchInfo.bathroomBegin = bathroomS
                searchInfo.bathroomEnd = bathroomE
                bathStart.text = String(bathroomS)
                if sector.endValue == sector.maxValue{
                    bathEnd.text = String(bathroomE) + "+"
                }else{
                    bathEnd.text = String(bathroomE)
                }
            }
            if sector.tag == 2{
                let priceS = lround(sector.startValue)
                let priceE = lround(sector.endValue)
                searchInfo.priceBegin = priceS
                searchInfo.priceEnd = priceE
                priceStart.text = String(priceS) + "万"
                if sector.endValue == sector.maxValue{
                    priceEnd.text = String(priceE) + "万+"
                    
                }else {
                    priceEnd.text = String(priceE) + "万"
                }
            }
        }
    }
    // DOPDropDownMenu setting
    
    
    func numberOfColumnsInMenu(menu: DOPDropDownMenu!) -> Int {
        return menuList.count
    }
    
    func menu(menu: DOPDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        let rows = menuList[column].count
        return rows
    }
    
    func menu(menu: DOPDropDownMenu!, titleForRowAtIndexPath indexPath: DOPIndexPath!) -> String! {
        let title = menuList[indexPath.column][indexPath.row]
        return title
    }
    
    func menu(menu: DOPDropDownMenu!, didSelectRowAtIndexPath indexPath: DOPIndexPath!) {
        let title = menuList[indexPath.column][indexPath.row]
        if indexPath.column == 0{
            searchInfo.city = title
        }else if indexPath.column == 1{
            searchInfo.type = title
        }else{
            searchInfo.right = title
        }
        
    }
    
    

    
}
