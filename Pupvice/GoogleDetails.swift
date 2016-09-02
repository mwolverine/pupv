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
    var rating: String?
    
    init(dictionary:[String : AnyObject])
        
    {
        let json = JSON(dictionary)
        text = json["text"].stringValue
        rating = json["rating"].stringValue
    }
}