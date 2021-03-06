//
//  GoogleDetails.swift
//  Pupvice
//
//  Created by Chris Yoo on 9/1/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class GoogleDetails {
    
    var text: String?
    var rating: Int?
    var authorName: String?
    var photoReference: String?
    var photo: UIImage?
    
    init(dictionary:[String : AnyObject])
        
    {
        let json = JSON(dictionary)
        text = json["text"].stringValue
        rating = json["rating"].intValue
        authorName = json["author_name"].stringValue
        
        photoReference = json["photos"][0]["photo_reference"].string

    }
}