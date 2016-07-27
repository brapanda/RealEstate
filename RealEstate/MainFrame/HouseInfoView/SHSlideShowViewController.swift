//
//  SHSlideShow.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-25.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import JT3DScrollView

class SHSlideShowViewController: UIViewController{
    
    var imageDataList = [UIImage]()
    var slideShow = JT3DScrollView(frame: CGRect(origin: CGPointZero,
        size: CGSize(width: screenWidth, height: screenHeight)))
    var toolBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(slideShow)
        
        toolBar = UIView()
        toolBar.frame = CGRectMake(0, 0, screenWidth, 64)
        toolBar.alpha = 1.0
        toolBar.backgroundColor = navigationColor
        
        let stop = UIButton(frame: CGRect(x: screenWidth - 50, y: 20, width: 30, height: 30))
        stop.setTitle(String.fontAwesomeIconWithName(FontAwesome.Close), forState: .Normal)
        stop.tintColor = closeColor
        stop.addTarget(self, action: "closeImageView", forControlEvents: .TouchUpInside)
        
        toolBar.addSubview(stop)
        
        let tapGR = UITapGestureRecognizer(target: self, action: "tapHandler:")
        tapGR.numberOfTapsRequired = 1
        tapGR.numberOfTouchesRequired = 1
        
        let tapDouble=UITapGestureRecognizer(target:self,action:"tapDouble:")
        tapDouble.numberOfTapsRequired=2
        tapDouble.numberOfTouchesRequired=1
        
        tapGR.requireGestureRecognizerToFail(tapDouble);
        self.view.addGestureRecognizer(tapDouble)
        self.view.addGestureRecognizer(tapGR)
        
        self.view.addSubview(toolBar)
        
    }
    
    func tapDouble(sender: UITapGestureRecognizer){
        
    }
    
    func tapHandler(sender: UITapGestureRecognizer){
        UIView.animateWithDuration(0.3, animations: {
            let offsetY : CGFloat = (self.toolBar.frame.origin.y >= 0 ? -64.0 : 0)
            
            let origin = CGPoint(x: 0, y: offsetY)
            let size = self.toolBar.frame.size
            let frame = CGRect(origin: origin, size: size)
            self.toolBar?.frame = CGRectOffset(frame, 0, offsetY)
            
        })
    }
    
    func closeImageView(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createImageView(image: UIImage){
        let width = CGRectGetWidth(self.slideShow.frame)
        let height = CGRectGetHeight(self.slideShow.frame)
        
        var x : CGFloat = CGFloat(slideShow.subviews.count) * width
        
        var imageView = VIPhotoView(frame: CGRect(x: x, y: 0,width: screenWidth, height: screenHeight), andImage: image)
        
        self.slideShow.contentSize = CGSizeMake(x + width, height)
        self.slideShow.addSubview(imageView)
        
    }
    
    func setUpImage(){
        for i in imageDataList{
            createImageView(i)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}