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
    let locationManager = CLLocationManager()
    let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 5000
    var placesArray2: [GooglePlace] = []

    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, keywords: searchedKeywords) { places in
            for place: GooglePlace in places {
                self.placesArray2.append(place)
            }
        }
    }
    
}