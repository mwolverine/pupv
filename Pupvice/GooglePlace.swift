//
//  GooglePlace.swift
//  Pupvice
//
//  Created by Chris Yoo on 8/30/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class GooglePlace {
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let placeKeyword: String
    var photoReference: String?
    var photo: UIImage?
    
    init(dictionary:[String : AnyObject], acceptedKeywords: [String])
    {
        let json = JSON(dictionary)
        name = json["name"].stringValue
        address = json["vicinity"].stringValue
        
        let lat = json["geometry"]["location"]["lat"].doubleValue as CLLocationDegrees
        let lng = json["geometry"]["location"]["lng"].doubleValue as CLLocationDegrees
        coordinate = CLLocationCoordinate2DMake(lat, lng)
        
        photoReference = json["photos"][0]["photo_reference"].string
        
        let foundKeyword = "dog park"
        //    let possibleKeywords = acceptedKeywords.count > 0 ? acceptedKeywords : ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
        //    for keyword in json["keyword"].arrayObject as! [String] {
        //      if possibleKeywords.contains(keyword) {
        //        foundKeyword = keyword
        //        break
        //      }
        //    }
        placeKeyword = foundKeyword
    }
}
