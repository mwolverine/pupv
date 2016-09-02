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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    func setupView(locationValue: CLLocationCoordinate2D){
        ListModelController.sharedController.fetchNearbyPlaces(locationValue) { (places) in
            self.placesArray = places
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    @IBAction func refreshPlaces(sender: AnyObject) {
        setupView(locationValue)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath)
        let place = placesArray[indexPath.row]
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.placeKeyword
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "placeDetailSegue" {
            if let detailViewController = segue.destinationViewController as? DetailPlaceTableViewController, indexPath = tableView.indexPathForSelectedRow
            {
                let detailPlace = ListModelController.sharedController.placesArray[indexPath.row]
                detailViewController.detailPlace = detailPlace
                
            }
        }
    }
}