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
    var GlobalMainQueue: dispatch_queue_t {
        return dispatch_get_main_queue()
    }
    
    var images: [UIImage] = []
    
    static let sharedController = DetailPlaceModelController()
    
    func fetchDetailPlace(placeID: String, completion: (reviews: [GoogleDetails], photos: [GoogleDetailsPhoto]) -> Void ) {
        dataProvider.fetchReviewFromPlaceID(placeID) { (reviews, photos) in
            completion(reviews: reviews, photos: photos)
        }
    }
    
    func fetchDetailPhoto(imageReferences: [GoogleDetailsPhoto], completion: (images: [UIImage])->Void) {
        images = []
        for reference in imageReferences {
            guard let reference = reference.photoReference else { return }
            dispatch_async(dispatch_get_main_queue(), {
                self.dataProvider.fetchPhotoFromReference(reference) { (image) in
                    guard let image = image else { return }
                    self.images.append(image)
                    completion(images: self.images)
                }
            })
        }
    }
}

