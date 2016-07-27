//
//  Macros.swift
//  RealEstate
//
//  Created by Shawn on 2016-03-09.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation

let screenSize = UIScreen.mainScreen().bounds
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height

let tabBarHeight : CGFloat = 49
let NavBarHeight : CGFloat = 44
let NavBarAndStatusHeight : CGFloat = 64.0

let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(25)] as Dictionary!

//search house type
var searchHouseInfo = houseSearchData()

//NavigationBar and TabBar setting
let navigationColor = UIColorFromRGB(0x388E3C)
let tabBarColor = UIColor.blackColor()

//MapView SegmentControl Setting
let mapTypeSegmentColor : UIColor = UIColorFromRGB(0xffffff)

//MapView Button Setting
let goToPano = UIColorFromRGB(0x4CAF50).CGColor

//Panorama Button Setting
let goToMap = UIColorFromRGB(0xFF5B7D).CGColor

//Map Marker Icon
let panoMarkerIcon = UIImage.fontAwesomeIconWithName(FontAwesome.StreetView,
                                                     textColor: UIColorFromRGB(0x555B7D),
                                                     size: CGSizeMake(50, 50))
let searchMarkerIcon = UIImage.fontAwesomeIconWithName(FontAwesome.MapPin,
                                                       textColor: UIColorFromRGB(0x66FABF6),
                                                       size: CGSizeMake(50, 50))
let houseMarkerIcon = UIImage.fontAwesomeIconWithName(FontAwesome.MapMarker,
                                                      textColor: UIColorFromRGB(0xFF5B7D),
                                                      size: CGSizeMake(50, 50))

//Filter color
let filterViewColor = UIColorFromRGB(0x414141)
let sector1Color = UIColorFromRGB(0xFF5B7D)
let sector2Color = UIColorFromRGB(0x00ABF6)
let sector3Color = UIColorFromRGB(0x80C97E)
let endCycleColor = UIColorFromRGB(0xB5C8D7)


//House List Setting
let onePiecesWidth = floor(screenWidth - houseCellEdge*4)
let onePiecesHeight = onePiecesWidth * 2 / 5
let houseCellEdge: CGFloat = 5.0
let listViewControlHeight : CGFloat = 30.0

let closeColor = UIColor.redColor()

//SHListCell setting
let addressLabelColor = UIColorFromRGB(0xFF5252)
let priceLabelColor = UIColor.blackColor()
let brokerageLabelColor = UIColor.grayColor()

let labelBgColor = UIColorFromRGB(0xf4f4f4)

let labelTextColor = UIColor.blackColor()

// House Info View Controller
let pageIndicatorColor = UIColor.blackColor()
let currentPageColor = UIColor.redColor()

//house info cell setting
let infoCellColor = UIColorFromRGB(0xFF5B7D)


