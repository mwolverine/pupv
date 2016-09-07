//
//  MainTableViewController.swift
//  Pupvice
//
//  Created by Chris Yoo on 8/29/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MainTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var locationValue: CLLocationCoordinate2D!
    var placesArray: [GooglePlace] = []
    var searchedKeywords: [String] = []
    var searchedType: [String] = []

    @IBAction func dogParkButtonTapped(sender: AnyObject) {
        searchedType = ["park"]
        searchedKeywords = ["dog+park"]
        setupView(locationValue)
    }
    
    @IBAction func restaurantsButtonTapped(sender: AnyObject) {
        searchedType = ["restaurant"]
        //bakery|bar|cafe|
        searchedKeywords = ["dog+friendly"]
        setupView(locationValue)
    }
    
    @IBAction func lodgingButtonTapped(sender: AnyObject) {
        searchedType = ["lodging"]
        //bakery|bar|cafe|
        searchedKeywords = ["dog+friendly"]
        setupView(locationValue)
    }
    
    @IBAction func storesButtonTapped(sender: AnyObject) {
        searchedType = ["pet_store"]
        searchedKeywords = ["dog"]
        setupView(locationValue)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "LogoWithName")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView

        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        tableView.reloadData()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        self.locationValue = locValue
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    func setupView(locationValue: CLLocationCoordinate2D){
        ListModelController.sharedController.fetchNearbyPlaces(locationValue, types: searchedType, keywords: searchedKeywords) { (places) in
            self.placesArray = places
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    @IBAction func refreshPlaces(sender: AnyObject) {
        setupView(locationValue)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath)
        let place = placesArray[indexPath.row]
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.rating
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "placeDetailSegue" {
            if let detailViewController = segue.destinationViewController as? DetailPlaceTableViewController, indexPath = tableView.indexPathForSelectedRow
            {
                let detailPlace = placesArray[indexPath.row]
                detailViewController.detailPlace = detailPlace
                
            }
        }
    }
}