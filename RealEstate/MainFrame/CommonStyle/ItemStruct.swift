//
//  ItemStruct.swift
//  RealEstate
//
//  Created by Shawn on 2016-04-24.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class HouseInfo : AnyObject{
    var cellImage : String?
    var imageList = [String]()
    
    var address : String?
    var price : String?
    var brokerage : String?
    
    var mlsID : String?
    var bedroom = String()
    var bathroom = String()
    var lotArea : String?
    
    var location : CLLocationCoordinate2D?
    
    init(cellImage: String,address:String,price:String,brokerage:String,mlsID: String,bedroom: String, bathroom: String,lotArea: String,location: CLLocationCoordinate2D){
        self.cellImage = cellImage
        self.address = address
        self.price = price
        self.brokerage = brokerage
        self.mlsID = mlsID
        self.bedroom = bedroom
        self.bathroom = bathroom
        self.lotArea = lotArea
        self.location = location
    }
    
}

var testHouse = HouseInfo(cellImage: "house.jpg", address: "37 Macklin Street", price: "$9,999,999,999", brokerage: "AimHome Brokerage 2777 Sheppard Ave East", mlsID: "N2323234", bedroom: "4 + 1", bathroom: "4", lotArea: "115ft x 200ft",location: CLLocationCoordinate2DMake(getRandomNumverBetween(41.717899, maxNumber:45.6723432),
    getRandomNumverBetween(-71.6582407, maxNumber:-81.6582407)))

func getRandomNumverBetween(min: Double, maxNumber max: Double) -> Double{
    let number = (min + (max - min)*drand48())
    return number
}

var dict = [String: String]()



struct Info{
    var title = ""
    var data = ""
    var chineseTitle : String{
        get {
            let chinese = dict[title]
            if chinese == nil{
                return title
            }else {
                return chinese!
            }
        }
    }
}

// FilterViewController Item struct


struct labelDesign{
    let startLabel : UILabel?
    let endLabel   : UILabel?
    let title : String?
    let toString : String?
    let titleColor : UIColor?
}

struct typeDesign{
    let chinese : String?
    let english : String?
}

class houseSearchData{
    
    var city = "城市(全部)"
    var type = "类型(全部)"
    var right = "产权(全部)"
    
    var bedroomBegin = 0
    var bedroomEnd = 4
    
    var bathroomBegin = 0
    var bathroomEnd = 4
    
    var priceBegin = 0
    var priceEnd = 200
    
    init(){}
    
    init(city: String,type: String, right: String,bedroomBegin: Int,bedroomEnd: Int,bathroomBegin: Int, bathroomEnd: Int, priceBegin: Int, priceEnd: Int){
        self.city = city
        self.type = type
        self.right = right
        self.bedroomBegin = bedroomBegin
        self.bedroomEnd = bedroomEnd
        self.bathroomBegin = bathroomBegin
        self.bathroomEnd = bathroomEnd
        self.priceBegin = priceBegin
        self.priceEnd = priceEnd
        
    }
    
    
}