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
    let rating: String
    let phoneNumber: String
    let website: String
    let cost: String
    var text: String?
    var photoReference: String?
    var photo: UIImage?
    
    //developers.google.com/places/web-service/details#PlaceDetailsResults
    
    init(dictionary:[String : AnyObject], acceptedKeywords: [String])
    {
        let json = JSON(dictionary)
        name = json["name"].stringValue
        rating = json["rating"].stringValue
        address = json["vicinity"].stringValue
        phoneNumber = json["formatted_phone_number"].stringValue
        website = json["website"].stringValue
        cost = json["price_level"].stringValue
        
        let lat = json["geometry"]["location"]["lat"].doubleValue as CLLocationDegrees
        let lng = json["geometry"]["location"]["lng"].doubleValue as CLLocationDegrees
        coordinate = CLLocationCoordinate2DMake(lat, lng)
        
        for review in json["reviews"].arrayValue {
            let text = review["text"].stringValue
            self.text = text
        }
        
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