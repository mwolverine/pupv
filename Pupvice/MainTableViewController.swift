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
        locationValue = locValue
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        ListModelController.sharedController.fetchNearbyPlaces(locationValue)
        tableView.reloadData()

    }
    
    // MARK: - Table view data source
    
    @IBAction func refreshPlaces(sender: AnyObject) {
        locationManager
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListModelController.sharedController.placesArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath)
        let place = ListModelController.sharedController.placesArray[indexPath.row]
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.placeKeyword
        return cell
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}