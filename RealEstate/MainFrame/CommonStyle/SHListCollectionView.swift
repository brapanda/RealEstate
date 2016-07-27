//
//  ListCollectionView.swift
//  RealEstate
//
//  Created by Shawn on 2016-03-10.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class SHListCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var dataS = [HouseInfo]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = UIColor.lightGrayColor()
        self.delegate = self
        self.dataSource = self
        self.registerClass(SHListCell.self, forCellWithReuseIdentifier: "SHListCell")
        
        //register a section HeaderView class
//        self.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCellWithReuseIdentifier("SHListCell", forIndexPath: indexPath) as! SHListCell
        let house = dataS[indexPath.row] as! HouseInfo
        if cell.tag == 0{
            if indexPath.row % 2 == 0{
                cell.backgroundColor = .whiteColor()
                cell.cellImage = UIImage(named: house.cellImage!)
                cell.address = house.address!
                cell.price = house.price!
                cell.brokerage = house.brokerage!
                cell.mlsID = house.mlsID
                cell.bedroom = house.bedroom
                cell.bathroom = house.bathroom
                cell.lotArea = house.lotArea
                cell.location = house.location
                cell.setHouseView()
            }else{
                cell.backgroundColor = .whiteColor()
                cell.cellImage = UIImage(named: house.cellImage!)
                cell.address = house.address!
                cell.price = house.price!
                cell.brokerage = house.brokerage!
                cell.mlsID = house.mlsID
                cell.bedroom = house.bedroom
                cell.bathroom = house.bathroom
                cell.lotArea = house.lotArea
                cell.location = house.location
                cell.setHouseView()
            }
                cell.tag = indexPath.row + 1
        }
        
        
//        for subview in cell.contentView.subviews{
//            if subview.isKindOfClass(UIImageView){
//                subview.removeFromSuperview()
//            }else if subview.isKindOfClass(UILabel){
//                subview.removeFromSuperview()
//            }
//        }
        
        return cell
    }
    
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
    
    //section HeaderView design
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", forIndexPath: indexPath)
//        headerView.backgroundColor = UIColor.grayColor()
//        return headerView
//    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataS.count
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}