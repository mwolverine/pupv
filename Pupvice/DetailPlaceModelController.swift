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
    
    let dataProvider = GoogleDataProvider()

    static let sharedController = DetailPlaceModelController()

    func fetchDetailPlace(placeID: String, completion: (reviews: [GoogleDetails]) -> Void ) {
        dataProvider.fetchReviewFromPlaceID(placeID) { reviews in
            completion(reviews: reviews)
        }
    }
}
