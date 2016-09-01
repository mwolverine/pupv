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
    
    
    init(dictionary:[String : AnyObject])
    {
        let json = JSON(dictionary)
        text = json["reviews"][0]["text"].stringValue
        
        //        for review in json["reviews"].arrayValue {
        //            let text = review["text"].stringValue
        //            self.text = text
        //        }
        
    }
}