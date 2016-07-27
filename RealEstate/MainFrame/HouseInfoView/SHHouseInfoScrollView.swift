////
////  SHHouseInfoScrollView.swift
////  RealEstate
////
////  Created by Shawn on 2016-04-20.
////  Copyright © 2016 Shawn. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//class SHHouseInfoScrollView: UIScrollView, UIScrollViewDelegate{
//    
//    var pageControl: UIPageControl!
//    var imageList : [String]!
//    var imageScrollView : UIScrollView!
//    
//    var houseInfoList = [houseInfo.init(tag: 1),houseInfo.init(tag: 2),houseInfo.init(tag: 3)]
//    var houseBeginTag : Int?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        //多线程下载图片
//        self.backgroundColor = UIColor.whiteColor()
////        imageScrollView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0,y: 0), size: frame.size))
////        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.frame.size.height - 20, width: self.frame.width, height: 20))
////        pageControl.pageIndicatorTintColor = pageIndicatorColor
////        pageControl.currentPageIndicatorTintColor = currentPageColor
////        
////        self.addSubview(imageScrollView)
////        
////        self.imageScrollView.delegate = self
//        
//        
//        
//        
//    }
//    
//    
//    func setUpImageView(){
//        let width : CGFloat = self.frame.width
//        let height : CGFloat = self.frame.height
//        
//        if imageList.isEmpty == false{
//            for i in 0...(imageList.count - 1){
//                let imageView = UIImageView()
//                let x = CGFloat(i) * width
//                imageView.frame = CGRectMake(x, 0, width, height)
//                imageView.image = UIImage(named: imageList[i])
//                imageView.clipsToBounds = true
//                imageView.contentMode = .ScaleToFill
//                self.imageScrollView.addSubview(imageView)
//                
//            }
//            
//            self.imageScrollView.pagingEnabled = true
//            self.imageScrollView.contentSize = CGSizeMake(CGFloat(imageList.count) * width, 0)
//            pageControl.numberOfPages = imageList.count
//        }
//        self.imageScrollView.showsHorizontalScrollIndicator = false
//        self.addSubview(pageControl)
//    }
//    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
////        let offset : CGPoint = self.imageScrollView.contentOffset
////        let offsetX: CGFloat = offset.x
////        let width : CGFloat = self.frame.width
////        self.pageControl.currentPage = (Int(offsetX + 0.5 * width) / Int(width))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//struct houseInfo{
//    var tag: Int?
//}