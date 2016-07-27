//
//  SHHouseInfoViewController.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-20.
//  Copyright © 2016 Shawn. All rights reserved.
//

import UIKit
import JT3DScrollView

class SHHouseInfoViewController: UIViewController,UIScrollViewDelegate{
    
    var houseInfoScrollView : UIScrollView!
    var houseData = [String]()
    
    var scrollView = JT3DScrollView(frame: CGRect(origin: CGPointZero,
        size: CGSize(width: screenWidth, height: screenHeight)))
    
    var dataS = [HouseInfo]()
    var beginPage = 0
    var createdPage = [Int]()
    var imgList = ["house.jpg","house2.jpg","house.jpg","house2.jpg","house2.jpg","house.jpg","house2.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
        
        scrollView.effect = .None
        scrollView.delegate = self
        self.view.addSubview(scrollView)

//        houseInfoScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        var houseInfo = SHScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        houseInfo.imageList = ["house.jpg","house.jpg","house.jpg","house.jpg","house.jpg","house.jpg"]
//        houseInfo.setUpData()
//        houseInfoScrollView.addSubview(houseInfo)
//        self.view.addSubview(houseInfoScrollView)
    
        
        var backButton = UIButton(type: .Custom)
        backButton.frame = CGRect(x: 5, y: 20, width: 50, height: 50)
        backButton.titleLabel!.font = UIFont.fontAwesomeOfSize(50)
        backButton.setTitle(String.fontAwesomeIconWithCode("fa-chevron-circle-left"), forState: .Normal)
        backButton.setTitleColor(navigationColor, forState: .Normal)
        backButton.setTitleColor(.whiteColor(), forState: .Highlighted)
        backButton.addTarget(self, action: #selector(SHHouseInfoViewController.backToList), forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton)
        
        setUpButton()
    }
    
    func setUpData(){
        createCard(dataS[beginPage] as! HouseInfo, page: beginPage)
        if dataS.count > 1 && beginPage == 0{
            scrollView.contentSize = CGSizeMake(scrollView.frame.width*2, scrollView.frame.height)
        }
        scrollView.loadPageIndex(UInt(beginPage), animated: false)
    }
    
    func backToList(){
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createCard(house: HouseInfo, page : Int){
        let width = CGRectGetWidth(scrollView.frame)
        let height = CGRectGetHeight(scrollView.frame)
        
        var x : CGFloat = CGFloat(page) * width
        
        var houseInfo = SHScrollView(frame: CGRect(x: x, y: 0,width: screenWidth, height: screenHeight))

        if imgList.isEmpty{
            houseInfo.imageList = ["default.png"]
        }else{
            houseInfo.imageList = self.imgList
        }
        
        houseInfo.houseLocation = house.location
        houseInfo.setUpData()
        houseInfo.cycleScrollView?.delegate = self
        
        
        if self.scrollView.contentSize.width < x + width{
            self.scrollView.contentSize = CGSizeMake(x + width, height)
        }
        self.scrollView.addSubview(houseInfo)
        self.createdPage.append(page)

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isKindOfClass(JT3DScrollView){
            let x = scrollView.contentOffset.x
            let currentPage = self.scrollView.currentPage()
            let currentPosition = CGFloat(currentPage)*scrollView.frame.width
            let newPage = Int(currentPage) + 1
            if x > currentPosition && dataS.count > newPage{
                if !createdPage.contains(newPage){
                    createCard(self.dataS[newPage], page: newPage)
                }
            }
            let lastPage = Int(currentPage) - 1
            if x < currentPosition && lastPage >= 0{
                if !createdPage.contains(lastPage){
                    createCard(self.dataS[lastPage], page: lastPage)
                }
            }
        }
        
    }
    
    func setUpButton(){
        let selfWidth = screenWidth
        let selfHeight = screenHeight
        let unitWidth = screenWidth / 2 - 1
        let height : CGFloat = 40
        
        let contactButton = UIButton(type: .Custom)
        contactButton.frame = CGRect(origin: CGPoint(x: 0,y: selfHeight - height),
                                     size: CGSize(width: unitWidth, height: height))
        contactButton.backgroundColor = navigationColor
        contactButton.alpha = 0.9
        contactButton.setTitle("联系我们", forState: .Normal)
        contactButton.setTitleColor(.whiteColor(), forState: .Normal)
        self.view.addSubview(contactButton)
        
        let mapButton = UIButton(type: .Custom)
        mapButton.frame = CGRect(x: contactButton.frame.maxX + 2, y: selfHeight - height,
                                 width: unitWidth, height: height)
        mapButton.backgroundColor = navigationColor
        mapButton.alpha = 0.9
        mapButton.setTitle("地图", forState: .Normal)
        mapButton.setTitleColor(.whiteColor(), forState: .Normal)
        mapButton.addTarget(self, action: "viewMap", forControlEvents: .TouchUpInside)
        self.view.addSubview(mapButton)
    }
    
    func viewMap(){
        let HMVC = SHHouseMapViewController()
        let house = dataS[Int(scrollView.contentOffset.x/screenWidth)] as! HouseInfo
        HMVC.houseLocation = house.location
        self.presentViewController(HMVC, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SHHouseInfoViewController : WXCycleScrollViewDelegate{
    func cycleScrollViewDidTapped(cycleScrollView: WXCycleScrollView, index: Int) {
        let SSVC = SHSlideShowViewController()
        SSVC.imageDataList = cycleScrollView.imageDataList
        SSVC.setUpImage()
        SSVC.modalTransitionStyle = .CrossDissolve
        self.presentViewController(SSVC, animated: true, completion: {
            SSVC.slideShow.loadPageIndex(UInt(index), animated: false)})
    }
    
    
}