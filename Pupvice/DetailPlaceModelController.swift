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
    
    var placesDetailArray: [GoogleDetails] = []
    var photoPlacesDetailArray: [UIImage] = []
    
    static let sharedController = DetailPlaceModelController()
    
    func fetchDetailPlace(placeID: String, completion: (reviews: [GoogleDetails], photos: [GoogleDetailsPhoto]) -> Void ) {
        dataProvider.fetchReviewFromPlaceID(placeID) { (reviews, photos) in
            for review: GoogleDetails in reviews {
                self.placesDetailArray.append(review)
            }
            guard let photos = photos else { return }
            let photoReferences = photos.flatMap { $0.photoReference }
            for reference in photoReferences {
                self.dataProvider.fetchPhotoFromReference(reference) { (image) in
                    self.photoPlacesDetailArray.append(image!)
                }
            }
            completion(reviews: reviews, photos: photos)
        }
    }
}


