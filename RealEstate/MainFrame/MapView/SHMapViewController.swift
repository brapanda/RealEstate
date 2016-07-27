//
//  SHMapViewController.swift
//  RealEstate
//
//  Created by Shawn on 2016-03-08.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import FBAnnotationClusteringSwift
import Alamofire

class SHMapViewController: UIViewController,CLLocationManagerDelegate{
    
    var mapView                     : GMSMapView?
    let autocompleteController      = GMSAutocompleteViewController()
    var PanoLocation                : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(0.0), longitude: Double(0.0))
    var listHouseView               : UIView?
    var propertyCount               : UILabel?
    var extraButton                 : UIBarButtonItem?
    var listView                    : SHListCollectionView!
    var dataS                       = [HouseInfo]()
    var searchMarker                = GMSMarker()
    var panoMarker                  = GMSMarker()
    var userInfoURL2                = "https://www.idxhome.com/restServices/cloud-idx/login"
    
    
    var locationManager = CLLocationManager()
    var clusterManager  : GClusterManager?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print(searchHouseInfo)
        if let mapViewY = mapView?.frame.origin.y{
            print(mapViewY)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // google map setting
        let origin = CGPoint(x: 0, y: NavBarAndStatusHeight)
        let size   = CGSize(width: screenSize.width,
                            height: screenSize.height - tabBarHeight - NavBarAndStatusHeight)
        
        mapView = GMSMapView(frame: CGRect(origin: origin, size: size))
        mapView!.settings.compassButton = true
        mapView!.settings.myLocationButton = true
        mapView!.delegate = self
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.mapView!.myLocationEnabled = true
        })
        
        locationManager.delegate = self
        let authstate = CLLocationManager.authorizationStatus()
        if authstate == CLAuthorizationStatus.NotDetermined{
            if #available(iOS 8.0, *) {
                locationManager.requestWhenInUseAuthorization()
            } else {
                // Fallback on earlier versions
            }
        } else {
                    // Fallback on earlier versions

        }
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        self.view.addSubview(mapView!)
        setButton()
        setSegment()
        
        
        // Search Bar
//        setSearchButton()
        
        //List House View
        setListHouseView()
        
        //Search Bar TableView setting
//        
//        var cgr = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height)
//        tableView = SHSearchTableView(frame: cgr, style: UITableViewStyle.Plain)
//        searchController.view.addSubview(tableView!)
        
        //self.mapView?.addSubview(tableview)
        
        //Clustering test
        clusterManager = GClusterManager(mapView: mapView, algorithm: NonHierarchicalDistanceBasedAlgorithm(), renderer: GDefaultClusterRenderer(mapView: mapView))
        mapView?.delegate = clusterManager
        
        for i in 1...200{
            let TestHouse = HouseInfo(cellImage: "house.jpg", address: "37 Macklin Street", price: "$9,999,999,999", brokerage: "AimHome Brokerage 2777 Sheppard Ave East", mlsID: "N2323234", bedroom: "4 + 1", bathroom: "4", lotArea: "115ft x 200ft",location: CLLocationCoordinate2DMake(getRandomNumverBetween(41.717899, maxNumber:45.6723432),
                getRandomNumverBetween(-71.6582407, maxNumber:-81.6582407)))
            
            let spot = self.generateSpot(TestHouse)
            clusterManager?.addItem(spot)
        }
        clusterManager?.cluster()
        clusterManager?.delegate = self
        
        self.listView.delegate = self
        getData()
    }
    
    var searchProfile = [
        "cityId": "12,20",
    ]
    
//    var searchProfile = [
        //        "cityId" : "Cameron Park,El Dorado Hills",
//        "propertyType" : "SFR",
//        "minListPrice" : "900000",
//        "maxListPrice" : "1200000",
//        "bedrooms" : "3",
        //        "fullBaths" : "2",
        //        "newConstructionYn" : false,
        //        "openHomesOnlyYn" : false,
        //        "squareFeet" : "3000",
        //        "lotAcres" : "0.1"
//    ]
    var listingParam = [
        
        "listingNumber" : "16009054",
        "boardId" : "13"
    ]
    
    func getData(){
        
        let parameters = [
            "clientId":"65912",
            "password":"cloudidx",
        ]
        
        Alamofire.request(.POST, userInfoURL2,parameters: parameters)
            .responseJSON { response in
//                print("request : \(response.request)")
//                print("response : \(response.response)")
//                print("data : \(response.data)")
//                print("result : \(response.result)")
                switch response.result{
                case .Success(let value):
                    var links = [String:String]()
                    if let Json = response.result.value{
                        let houseInfo = JSON(Json).dictionaryValue
                        let infoLink = houseInfo["links"]?.array
                        for link in infoLink!{
                            links[link["rel"].string!] = link["href"].string
                        }
                        for (key, value) in links{
                            if key == "detail"{
                                Alamofire.request(.GET, value,parameters: self.listingParam).responseJSON {response in
                                    if let itemInfo = response.result.value{
                                        let item = JSON(itemInfo).dictionaryValue
                                        let listingDetail = item["listingDetailDto"]?.dictionaryValue
                                        for (key,value) in listingDetail!{
                                            print("key: \(key)   value : \(value)")
                                        }
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                    break
                case .Failure(let error):
                    print("error \(error)")
                    //do error handling

                    break
                }
        }
    }
    
    //////////////////////////////////////////////
    //        Clustering houses
    
    func generateSpot(house: AnyObject) -> Spot {
        let houseInfo = house as! HouseInfo
        let marker   = GMSMarker()
        marker.icon  = houseMarkerIcon
        marker.position = houseInfo.location!
        marker.userData = house
        
        let spot = Spot()
        spot.location = marker.position
        spot.marker = marker
        return spot
    }
    
    func getRandomNumverBetween(min: Double, maxNumber max: Double) -> Double{
        let number = (min + (max - min)*drand48())
        return number
    }
    
    ////////////////////////////////////////
    // google map delegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        goToNewPlace(locations[0].coordinate)
        PanoLocation = locations[0].coordinate
        locationManager.stopUpdatingLocation()
    }
    
    //go to new place
    func goToNewPlace(coordinate: CLLocationCoordinate2D){
        self.mapView!.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 14)
    }
    
    func setButton(){
        
        // Panorama View Button
        let origin = CGPoint(x: self.mapView!.frame.width - 65, y: self.mapView!.frame.height - 150)
        let size   = CGSize(width: 60, height: 60)
        var goToPanoButton = UIButton(frame: CGRect(origin: origin, size: size))
        goToPanoButton.layer.cornerRadius = 30
        goToPanoButton.layer.backgroundColor = goToPano
        goToPanoButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        goToPanoButton.layer.shadowRadius = 5
        goToPanoButton.layer.shadowOpacity = 0.9
        goToPanoButton.layer.shadowColor = UIColor.grayColor().CGColor
        
        goToPanoButton.titleLabel?.font = UIFont.fontAwesomeOfSize(35)
        goToPanoButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.StreetView),
                                forState: UIControlState.Normal)
        goToPanoButton.setTitleColor(.whiteColor(), forState: .Normal)
        goToPanoButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        
        goToPanoButton.addTarget(self, action: "goToPanoView",
                                 forControlEvents: .TouchUpInside)
        
        
        // Filter Button
        let filterButton = UIBarButtonItem()
        filterButton.target = self
        filterButton.action = "filterSetting"
        filterButton.setTitleTextAttributes(attributes, forState: .Normal)
        filterButton.title = String.fontAwesomeIconWithName(FontAwesome.Sliders)
        filterButton.tintColor = mapTypeSegmentColor
        self.navigationItem.leftBarButtonItem = filterButton
        
        // Search Button
        let searchButton = UIBarButtonItem()
        searchButton.target = self
        searchButton.action = "goToSearchView"
        searchButton.setTitleTextAttributes(attributes, forState: .Normal)
        searchButton.title = String.fontAwesomeIconWithName(FontAwesome.Search)
        searchButton.tintColor = mapTypeSegmentColor
        self.navigationItem.rightBarButtonItem = searchButton
        
        
        self.mapView!.addSubview(goToPanoButton)
    }
    
    // set segment mapview or aerial view control
    func setSegment(){
        let items = ["普通地图","卫星地图"]
        let mapTypeSegment = UISegmentedControl(items: items)
        mapTypeSegment.selectedSegmentIndex = 0
        mapTypeSegment.frame = CGRectMake(0, 0, 100, 30)
        mapTypeSegment.addTarget(self, action: "switchMapView:", forControlEvents: .ValueChanged)
        mapTypeSegment.tintColor = mapTypeSegmentColor
        self.navigationItem.titleView = mapTypeSegment
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
    
    func filterSetting(){
        let FVC = SHFilterViewController()
        FVC.modalTransitionStyle = .CrossDissolve
        FVC.searchInfo = searchHouseInfo
        self.presentViewController(FVC, animated: true, completion: nil)
    }
    
    func goToSearchView(){
        autocompleteController.delegate = self
        self.presentViewController(autocompleteController, animated: false, completion: nil)
    }
    
    
//    func setSearchButton(){
//        
//        self.searchController = UISearchController(searchResultsController: nil)
//        
//        self.searchController.searchResultsUpdater = self
//        self.searchController.delegate = self
//        self.searchController.searchBar.delegate = self
//        
//        self.searchController.hidesNavigationBarDuringPresentation = false
//        self.searchController.dimsBackgroundDuringPresentation = true
//        self.navigationItem.titleView = searchController.searchBar
//        self.definesPresentationContext = true
//        
//    }
    
    func goToPanoView(){
        let PVC = SHPanoramaViewConterller()
        PVC.PanoLocation = self.PanoLocation
        PVC.modalTransitionStyle = .FlipHorizontal
        self.presentViewController(PVC, animated: true, completion: nil)
        
    }

// google map delegate
///////////////////////////////////////////////////////////////////////////////////
    
// Search Bar delegate
    
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        print("searchbar updateing")
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

    /////////////////////////////////////////////////////
    //      hide TabBar and NavBar
    
    func  setTabBarVisible(visible: Bool, animated: Bool){
        if (tabBarIsVisible() == visible) {return}
        if (navBarIsVisible() && !tabBarIsVisible()) {return}
        let frame = self.tabBarController?.tabBar.frame
        let offsetY : CGFloat = (visible ? -tabBarHeight : tabBarHeight)
        let errY : CGFloat = (visible ? -15.0 : 15.0)
        
        let duration: NSTimeInterval = (animated ? 0.3 : 0.0)
        
        if frame != nil{
            UIView.animateWithDuration(duration){
                
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!,0,offsetY)
                
                let origin = CGPoint(x: (self.mapView?.frame.origin.x)! ,
                                     y: (self.mapView?.frame.origin.y)! + errY)
                
                let size = CGSize(width: (self.mapView?.frame.size.width)!,
                                  height: (self.mapView?.frame.size.height)! + offsetY)
                
                let newMapViewFrame = CGRect(origin: origin, size: size)
                self.mapView?.frame = CGRectOffset(newMapViewFrame, 0, offsetY)
                
                return
            }
        }
    }
    func tabBarIsVisible() -> Bool{
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }
    
    func setNavBarVisible(visible:Bool, animated: Bool){
        if (navBarIsVisible() == visible) {return}
        let frame = self.navigationController?.navigationBar.frame
        let offsetY : CGFloat = (visible ? NavBarAndStatusHeight : -NavBarAndStatusHeight)

        let duration : NSTimeInterval = (animated ? 0.3 : 0.0)
        if frame != nil{
            UIView.animateWithDuration(duration){

                let origin = CGPoint(x: (self.mapView?.frame.origin.x)! ,
                                     y: (self.mapView?.frame.origin.y)! + offsetY)
                
                let size   = CGSize(width: (self.mapView?.frame.size.width)!,
                                  height: (self.mapView?.frame.size.height)! - offsetY)
                
                let newMapViewFrame = CGRect(origin: origin, size: size)
                self.mapView?.frame = CGRectOffset(newMapViewFrame, 0, offsetY)
                
                
                self.navigationController?.navigationBar.frame = CGRectOffset(frame!, 0, offsetY)
                return
            }
        }
    }
    
    func navBarIsVisible() -> Bool{
        return self.navigationController?.navigationBar.frame.origin.y > CGRectGetMinY(screenSize)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let frame = self.navigationController?.navigationBar.frame
        if navBarIsVisible() && !tabBarIsVisible(){
            let duration : NSTimeInterval = 0.3
            if frame != nil{
                UIView.animateWithDuration(duration){
                    self.navigationController?.navigationBar.frame = CGRectOffset(frame!, 0, -NavBarAndStatusHeight)
                    return
                }
            }
        }
        return
    }
    
    
    /////////////////////////////////////////////////////////
    //     set listHouseView
    
    func setListHouseView(){
        let origin                     = CGPoint(x: 0, y: self.mapView!.frame.size.height)
        let size                       = CGSize(width: screenWidth,
                                                height: onePiecesHeight + listViewControlHeight + houseCellEdge*2)
        listHouseView                  = UIView(frame: CGRect(origin: origin, size: size))
        listHouseView?.backgroundColor = UIColor.lightGrayColor()
        listHouseView?.alpha = 1.0
        
        let layout                 = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSizeMake(screenWidth, 0)
        listView                   = SHListCollectionView(frame: CGRect(x: 0, y: listViewControlHeight,
                                                          width: screenSize.width,
                                                          height: listHouseView!.frame.size.height - listViewControlHeight),
                                                          collectionViewLayout: layout)
        
        self.listHouseView!.addSubview(listView)
        
        
        let toolBar = UIToolbar()
        toolBar.frame = CGRectMake(0, 0, screenWidth, listViewControlHeight)
        toolBar.backgroundColor = .whiteColor()
        
        let stop = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "closeListView")
        stop.tintColor = closeColor
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        let fixed = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: nil)
        
        
        extraButton = UIBarButtonItem()
        extraButton?.target = self
        extraButton?.action = "extraSize"
        extraButton!.setTitleTextAttributes(attributes, forState: .Normal)
        extraButton!.tintColor = UIColor.grayColor()
        extraButton!.title = String.fontAwesomeIconWithName(FontAwesome.AngleUp)
        
        propertyCount              = UILabel(frame: CGRect(x: 5, y: 0,
                                            width: screenWidth*0.3,
                                            height: toolBar.frame.size.height))
        propertyCount!.text        = "共0/0个物业"
        propertyCount!.font        = UIFont(name: "Helvetica Neue", size: 12)
        
        

        
        toolBar.items = [flexible,extraButton!,flexible,stop]
        toolBar.addSubview(propertyCount!)
        listHouseView?.addSubview(toolBar)

        self.mapView!.addSubview(listHouseView!)
    }
    
    func listHouseViewWillAppear(marker: GMSMarker){
        let duration : NSTimeInterval = 0.3
        if let markerData = marker.userData{
            if marker.title == "multiple"{
                let _markerData = markerData as! GStaticCluster
                propertyCount?.text = "共\(dataS.count)/\(_markerData.items.count)个物业"
            }else{
                        propertyCount?.text = "共\(dataS.count)/1个物业"
            }
        }
        
        listView.dataS = self.dataS
        listView.reloadData()
        listView.setContentOffset(CGPointZero, animated: false)
        let origin = CGPoint(x: 0, y: self.mapView!.frame.size.height)
        let size = self.listHouseView?.frame.size
        let frame = CGRect(origin: origin, size: size!)
        if frame.origin.y >= mapView!.frame.size.height{
            let offsetY = frame.size.height
            UIView.animateWithDuration(duration){
                self.listHouseView!.frame = CGRectOffset(frame, 0, -offsetY)
            }
        }
    }
    
    func listHouseViewWillClose(){
        let duration : NSTimeInterval = 0.3
        let size   = CGSize(width: screenWidth,
                            height: onePiecesHeight + listViewControlHeight + houseCellEdge*2)
        
        let frame = CGRect(origin: self.listHouseView!.frame.origin,size: size)
        if frame.origin.y <= mapView!.frame.size.height{
            let offsetY = self.mapView!.frame.size.height - frame.origin.y
            UIView.animateWithDuration(duration){
                self.listHouseView?.frame = CGRectOffset(frame, 0, offsetY)
                self.extraButton?.title = String.fontAwesomeIconWithName(FontAwesome.AngleUp)
            }
        }
    }
    
    func extraSize(){
        let currentHeight = self.listHouseView?.frame.size.height
        let mapViewHeight = self.mapView?.frame.size.height
        let currentOrigin = self.listHouseView?.frame.origin
        let currentSize   = self.listHouseView?.frame.size
        if currentHeight! <= mapViewHeight!/2 || (currentOrigin!.y > 20 && currentOrigin!.y < 300){
            extraButton?.title = String.fontAwesomeIconWithName(FontAwesome.AngleDown)
            let setHeight = min(mapViewHeight!,screenHeight - 20)
            UIView.animateWithDuration(0.3){
                let origin = CGPoint(x: 0, y: mapViewHeight! - setHeight)
                let size   = CGSize(width: screenWidth, height: setHeight)
                let frame  = CGRect(origin: origin, size: size)
                self.listHouseView?.frame = CGRectOffset(frame, 0, 0)
            }
        }else {
            extraButton?.title = String.fontAwesomeIconWithName(FontAwesome.AngleUp)
            let offsetY = mapViewHeight! - (onePiecesHeight + listViewControlHeight + houseCellEdge*2)
            UIView.animateWithDuration(0.3){
                let origin = CGPoint(x: 0, y: offsetY)
                let size   = CGSize(width: screenWidth,
                                  height: onePiecesHeight + listViewControlHeight + houseCellEdge*2)
                let frame  = CGRect(origin: origin, size: size)
                self.listHouseView?.frame = CGRectOffset(frame, 0, 0)
            }
        }
        let newListViewFrame = CGRect(x: 0, y: listViewControlHeight,
                                      width: screenSize.width,
                                      height: listHouseView!.frame.size.height - listViewControlHeight)
        UIView.animateWithDuration(0.0){
            self.listView.frame = CGRectOffset(newListViewFrame, 0, 0)
        }
    }
    
    func closeListView(){
        self.listHouseViewWillClose()
    }
}



extension SHMapViewController: GMSMapViewDelegate{
    func mapView(mapView: GMSMapView, didChangeCameraPosition position: GMSCameraPosition) {
        let center = position.target
        
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        self.dataS.removeAll()
        if let a = marker.userData {
            if marker.title == "multiple"{
            let b = a as! GStaticCluster
            for i in b.items{
                let h = i as! GQuadItem
                self.dataS.append(h.marker.userData as! HouseInfo)
                }
            }else{
                self.dataS.append(a as! HouseInfo)
            }
        }
        self.PanoLocation = marker.position
        
        if marker.userData != nil{
            
            self.listHouseViewWillAppear(marker)
        }
        return true
    }
    
    func mapView(mapView: GMSMapView, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        self.panoMarker.map      = nil
        self.panoMarker.position = coordinate
        self.panoMarker.icon     = panoMarkerIcon
        self.PanoLocation        = coordinate
        self.panoMarker.map = self.mapView
    }
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        
        self.extraButton?.title = String.fontAwesomeIconWithName(FontAwesome.AngleUp)
        setTabBarVisible(!tabBarIsVisible(),animated: true)
        setNavBarVisible(!navBarIsVisible(), animated: true)
        self.listHouseViewWillClose()
    }
    

    
}

//extension SHMapViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        print("searchButtonClicked")
//    }
//    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
//        print("beginEditing")
//        return true
//    }
//}


extension SHMapViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController, didAutocompleteWithPlace place: GMSPlace) {
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress)
        print("Place attributions: ", place.attributions)
        
        //set self searchBar address
        
        //set mapView searchBar address
//        self.searchController.searchBar.text = (place.formattedAddress! == nil ? "" : place.formattedAddress!)
        
        //clear searchMarker
        self.searchMarker.map = nil
        self.panoMarker.map = nil
        
        //set panoramaView location
        self.PanoLocation = place.coordinate
        
        //go to new place on mapView
        self.goToNewPlace(place.coordinate)
        
        //set marker on mapView
        self.searchMarker.position = place.coordinate
        self.searchMarker.icon     = searchMarkerIcon
        self.searchMarker.map      = self.mapView
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }
    
    func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError) {
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
    // User canceled the operation.
    func wasCancelled(viewController: GMSAutocompleteViewController) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(viewController: GMSAutocompleteViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(viewController: GMSAutocompleteViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
}

extension SHMapViewController: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let threePiecesWidth = floor(screenWidth / 3.0 - ((4.0 / 3) * 2))
        let twoPiecesWidth = floor(screenWidth / 2.0 - (4.0 / 2))
        return CGSizeMake(onePiecesWidth, onePiecesHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(houseCellEdge, houseCellEdge*2, houseCellEdge, houseCellEdge*2)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let HIVC = SHHouseInfoViewController()
        HIVC.dataS = self.dataS
        HIVC.beginPage = indexPath.row
        HIVC.setUpData()
        HIVC.modalTransitionStyle = .CrossDissolve
        self.presentViewController(HIVC, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let currentOrigin = listHouseView!.frame.origin
        let currentSize = listHouseView!.frame.size
//        if offsetY < 0 && offsetY > -30 && currentOrigin.y < (mapView?.frame.height)!/2{
//            let origin = CGPoint(x: 0, y: currentOrigin.y - offsetY)
//            let size = CGSize(width: currentSize.width, height: currentSize.height + offsetY)
//            listHouseView!.frame = CGRect(origin: origin, size: size)
//            
//        }
        if offsetY < 0 && currentSize.height > (mapView?.frame.size.height)!/2 && scrollView.dragging == false{
            extraSize()
        }
    }
    
    

}
