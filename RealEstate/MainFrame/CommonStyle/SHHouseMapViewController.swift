//
//  SHHouseMapViewController.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-24.
//  Copyright © 2016 Shawn. All rights reserved.
//

import UIKit
import CoreLocation

class SHHouseMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var houseLocation: CLLocationCoordinate2D!
    var mapView : GMSMapView?
    var locationManager = CLLocationManager()
    var houseLocationMarker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let origin = CGPoint(x: 0, y: 0)
        let size   = CGSize(width: screenSize.width,
                            height: screenSize.height)
        
        mapView = GMSMapView(frame: CGRect(origin: origin, size: size))
        mapView!.settings.compassButton = true
        mapView!.settings.myLocationButton = true
        self.view.addSubview(mapView!)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.mapView!.myLocationEnabled = true
        })
        
        let authstate = CLLocationManager.authorizationStatus()
        if authstate == CLAuthorizationStatus.NotDetermined{
            if #available(iOS 8.0, *) {
                    locationManager.requestWhenInUseAuthorization()
                } else {
                    // Fallback on earlier versions
            }
        }
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        if houseLocation != nil{
            mapView!.camera = GMSCameraPosition.cameraWithTarget(houseLocation, zoom: 14.0)
            houseLocationMarker.title = ""
            houseLocationMarker.position = houseLocation
            houseLocationMarker.icon = houseMarkerIcon
            houseLocationMarker.map = mapView
        }
        
        var backButton = UIButton(type: .Custom)
        backButton.frame = CGRect(x: 5, y: 20, width: 30, height: 30)
        backButton.titleLabel!.font = UIFont.fontAwesomeOfSize(30)
        backButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.ChevronDown), forState: .Normal)
        backButton.setTitleColor(navigationColor, forState: .Normal)
        backButton.setTitleColor(.whiteColor(), forState: .Highlighted)
        backButton.addTarget(self, action: "backToHouse", forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton)
        
        setSegment()
    }
    
    func backToHouse(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setSegment(){
        let items = ["普通地图","卫星地图"]
        let mapTypeSegment = UISegmentedControl(items: items)
        mapTypeSegment.selectedSegmentIndex = 0
        mapTypeSegment.frame = CGRectMake(screenWidth/2 - 100, 20, 200, 30)
        mapTypeSegment.addTarget(self, action: "switchMapView:", forControlEvents: .ValueChanged)
        mapTypeSegment.tintColor = mapTypeSegmentColor
        self.mapView!.addSubview(mapTypeSegment)
    }
    
    func switchMapView(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            mapView?.mapType = kGMSTypeNormal
            break
        case 1:
            mapView?.mapType = kGMSTypeHybrid
            break
        default:
            break
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        goToNewPlace(locations[0].coordinate)
        locationManager.stopUpdatingLocation()
    }
    
    //go to new place
    func goToNewPlace(coordinate: CLLocationCoordinate2D){
        self.mapView!.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 14)
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
