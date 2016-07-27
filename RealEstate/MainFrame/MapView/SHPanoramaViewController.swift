//
//  SHPanoramaViewController.swift
//  RealEstate
//
//  Created by Shawn on 2016-03-29.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class SHPanoramaViewConterller: UIViewController,GMSPanoramaViewDelegate {
    
    var PanoView : GMSPanoramaView?
    var PanoLocation : CLLocationCoordinate2D?
    var panoMarker = GMSMarker()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        PanoView = GMSPanoramaView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        PanoView!.delegate = self
        
        if PanoLocation == nil{
            PanoLocation = CLLocationCoordinate2DMake(-33.732, 150.312)
        }
        moveNearPano(PanoLocation!)
        
        self.view = PanoView
        
        setButton()
    }
    
    func moveNearPano(location: CLLocationCoordinate2D){
        self.panoMarker.panoramaView = nil
        self.panoMarker.position = location
        self.panoMarker.icon = panoMarkerIcon
        self.panoMarker.panoramaView = self.PanoView!
    
        self.PanoView!.moveNearCoordinate(location)
    }
    
    func setButton(){
        // Panorama View Button
        let origin = CGPoint(x: self.PanoView!.frame.width - 65, y: self.PanoView!.frame.maxY - 199)
        let size   = CGSize(width: 60, height: 60)
        var goToMapButton = UIButton(frame: CGRect(origin: origin, size: size))
        goToMapButton.layer.backgroundColor = goToMap
        goToMapButton.layer.cornerRadius = 30
        goToMapButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        goToMapButton.layer.shadowRadius = 5
        goToMapButton.layer.shadowOpacity = 0.9
        goToMapButton.layer.shadowColor = UIColor.grayColor().CGColor
        
        goToMapButton.titleLabel?.font = UIFont.fontAwesomeOfSize(35)
        goToMapButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.Road),
                                forState: UIControlState.Normal)
        goToMapButton.setTitleColor(.whiteColor(), forState: .Normal)
        goToMapButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        
        goToMapButton.addTarget(self, action: "goToMapView",
                                forControlEvents: .TouchUpInside)
        
        self.view.addSubview(goToMapButton)
    }
    
    func goToMapView(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func panoramaView(view: GMSPanoramaView, didMoveToPanorama panorama: GMSPanorama?) {
        
    }
    
    func panoramaView(view: GMSPanoramaView, willMoveToPanoramaID panoramaID: String) {
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}