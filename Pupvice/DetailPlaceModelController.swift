//
//  DetailPlaceModelController.swift
//  Pupvice
//
//  Created by Chris Yoo on 9/2/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation

class DetailPlaceModelController{
    
    var placesDetailArray: [GoogleDetails] = []

    static let sharedController = DetailPlaceModelController()
    
    func fetchDetailPlace(placeID: String, completion: ()->Void) {
        dataProvider.fetchReviewFromPlaceID(placeID) { reviews in
            for review: GoogleDetails in reviews {
                self.placesDetailArray.append(review)
            }
        }
    }
    
}
