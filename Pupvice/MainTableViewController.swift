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

    @IBOutlet weak var parkOutlet: UIButton!
//    @IBOutlet weak var foodOutlet: UIButton!
    @IBOutlet weak var lodgingOutlet: UIButton!
    @IBOutlet weak var storeOutlet: UIButton!
    @IBOutlet weak var vetOutlet: UIButton!
    
    @IBAction func dogParkButtonTapped(sender: AnyObject) {
        parkOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        lodgingOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        storeOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        vetOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        
        searchedType = ["park"]
        searchedKeywords = ["dog+park"]
        setupView(locationValue)
    }
    
//    @IBAction func restaurantsButtonTapped(sender: AnyObject) {
//        parkOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
//        lodgingOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        storeOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        vetOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        
//        searchedType = ["restaurant"]
//        //bakery|bar|cafe|
//        searchedKeywords = ["dog+friendly"]
//        setupView(locationValue)
//    }
    
    @IBAction func lodgingButtonTapped(sender: AnyObject) {
        parkOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        lodgingOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
        storeOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        vetOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        
        searchedType = ["lodging"]
        //bakery|bar|cafe|
        searchedKeywords = ["dog+friendly"]
        setupView(locationValue)
    }
    
    @IBAction func storesButtonTapped(sender: AnyObject) {
        parkOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        lodgingOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        storeOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
        vetOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        
        searchedType = ["pet_store"]
        searchedKeywords = ["dog"]
        setupView(locationValue)
        
    }
    
    @IBAction func vetButtonTapped(sender: AnyObject) {
        parkOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        lodgingOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        storeOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        vetOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
        
        searchedType = ["veterinary_care"]
        searchedKeywords = ["dog"]
        setupView(locationValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.title = "back"
        
        let logo = UIImage(named: "logoWithNameSmall")
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
        
        dogParkButtonTapped(self)

        tableView.reloadData()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let isFirstLocation = self.locationValue == nil
        self.locationValue = locValue
        if isFirstLocation {
        setupView(locationValue)
        }
    }

    func setupView(locationValue: CLLocationCoordinate2D?){
        guard let locationValue = locationValue else { return }
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