//
//  SHListViewController.swift
//  RealEstate
//
//  Created by Shawn on 2016-03-08.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class SHListViewController: UIViewController {
    
    var listView : SHListCollectionView!
    var dataS = [HouseInfo]()
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for i in 1...9{
            dataS.append(testHouse)
        }
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSizeMake(screenWidth, 20)
        listView = SHListCollectionView(frame: CGRect(x: 0, y: 0,
                                        width: screenSize.width,
                                        height: screenSize.height),
                                        collectionViewLayout: layout)
        listView.dataS = self.dataS
        self.view.addSubview(listView)
        self.view.backgroundColor = UIColor.whiteColor()
        self.listView.delegate = self
        
        // Filter Button
        let filterButton = UIBarButtonItem()
        filterButton.target = self
        filterButton.action = "filterSetting"
        filterButton.setTitleTextAttributes(attributes, forState: .Normal)
        filterButton.title = String.fontAwesomeIconWithName(FontAwesome.Sliders)
        filterButton.tintColor = mapTypeSegmentColor
        self.navigationItem.leftBarButtonItem = filterButton
        
    }
    
    func filterSetting(){
        let FVC = SHFilterViewController()
        FVC.modalTransitionStyle = .CrossDissolve
        FVC.searchInfo = searchHouseInfo
        self.presentViewController(FVC, animated: true, completion: nil)
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

extension SHListViewController: UICollectionViewDelegate{
    
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
    
}
