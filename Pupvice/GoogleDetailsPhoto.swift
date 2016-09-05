//
//  GoogleDetailsPhoto.swift
//  Pupvice
//
//  Created by Chris Yoo on 9/5/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class GoogleDetailsPhoto {
    
    var photoReference: String?
    var photo: UIImage?
    
    init(dictionary:[String : AnyObject])
        
    {
        let json = JSON(dictionary)
        photoReference = json["photo_reference"].string
    }
}
