//
//  MainListMVC.swift
//  Pupvice
//
//  Created by Chris Yoo on 8/31/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation

class ListModelController {
    
    static let sharedController = ListModelController()
    
    var searchedKeywords = ["dog park"]
    var searchedType = ["park"]
    let locationManager = CLLocationManager()
    let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 4000
    
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D, completion: (places: [GooglePlace])->Void) {
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedType, keywords: searchedKeywords) { places in
            completion(places: places)
        }
    }
}

