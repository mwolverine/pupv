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
    
    let locationManager = CLLocationManager()
    let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 6000
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D, types: [String], keywords: [String], completion: (places: [GooglePlace])->Void) {
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: types, keywords: keywords) { places in
            completion(places: places)
        }
    }
}

