//
//  MapViewController.swift
//  Pupvice
//
//  Created by Chris Yoo on 8/30/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit
import GoogleMaps

class PupMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapCenterPinImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var pinImageVerticalConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var detailViewStack: UIStackView!
    
    
    @IBOutlet weak var detailButtonOutlet: UIButton!
    @IBOutlet weak var directionPathButtonOutlet: UIButton!
    
    
    var googlePlace: GooglePlace?
    var searchedKeywords: [String] = []
    var searchedType: [String] = []
    let locationManager = CLLocationManager()
    let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 3000
    
    @IBOutlet weak var parkOutlet: UIButton!
//    @IBOutlet weak var foodOutlet: UIButton!
    @IBOutlet weak var lodgingOutlet: UIButton!
    @IBOutlet weak var storeOutlet: UIButton!
    @IBOutlet weak var vetOutlet: UIButton!
    
    @IBAction func dogParkButtonTapped(sender: AnyObject) {
        removeButtonsFromScreen()

        parkOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        lodgingOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        storeOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        vetOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        
        searchedType = ["park"]
        searchedKeywords = ["dog+park"]

        fetchNearbyPlaces(mapView.camera.target)
    }
    
//    @IBAction func restaurantsButtonTapped(sender: AnyObject) {
//        removeButtonsFromScreen()
//
//        parkOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
//        lodgingOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        storeOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        vetOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        
//        searchedType = ["restaurant"]
//        //bakery|bar|cafe|
//        searchedKeywords = ["dog friendly"]
//        fetchNearbyPlaces(mapView.camera.target)
//    }
//    
    @IBAction func lodgingButtonTapped(sender: AnyObject) {
        removeButtonsFromScreen()

        parkOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        lodgingOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
        storeOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        vetOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        
        searchedType = ["lodging"]
        //bakery|bar|cafe|
        searchedKeywords = ["dog+friendly"]
        fetchNearbyPlaces(mapView.camera.target)
    }
    
    @IBAction func storesButtonTapped(sender: AnyObject) {
        removeButtonsFromScreen()

        parkOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        lodgingOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        storeOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
        vetOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        
        searchedType = ["pet_store"]
        searchedKeywords = ["dog"]
        fetchNearbyPlaces(mapView.camera.target)
        
    }
    
    @IBAction func vetButtonTapped(sender: AnyObject) {
        removeButtonsFromScreen()

        parkOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
//        foodOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        lodgingOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        storeOutlet.backgroundColor = UIColor(red: 36.0/255.0, green: 47/255.0, blue: 65/255.0, alpha: 1.0)
        vetOutlet.backgroundColor = UIColor(red: 85.0/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
        
        searchedType = ["veterinary_care"]
        searchedKeywords = ["dog"]
        fetchNearbyPlaces(mapView.camera.target)
    }
    
    //veterinary_care lodging
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "logoWithNameSmall")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        removeButtonsFromScreen()
        dogParkButtonTapped(self)
        mapView.delegate = self
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "Searches Segue" {
    //            let navigationController = segue.destinationViewController as! UINavigationController
    //            let controller = navigationController.topViewController as! SearchesTableViewController
    //            controller.selectedSearches = searchedKeywords
    //            controller.delegate = self
    //        }
    //    }
    
    func removeButtonsFromScreen(){
        detailViewStack.userInteractionEnabled = false
        detailButtonOutlet.hidden = true
        detailButtonOutlet.enabled = false
        directionPathButtonOutlet.hidden = true
        directionPathButtonOutlet.enabled = false
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            self.addressLabel.unlock()
            if let address = response?.firstResult() {
                let lines = address.lines as [String]!
                self.addressLabel.text = lines.joinWithSeparator("\n")
                
                let labelHeight = self.addressLabel.intrinsicContentSize().height
                self.mapView.padding = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: labelHeight, right: 0)
                
                UIView.animateWithDuration(0.25) {
                    self.pinImageVerticalConstraint.constant = ((labelHeight - self.topLayoutGuide.length) * 0.5)
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedType, keywords: searchedKeywords) { places in
            for place: GooglePlace in places {
                let marker = PlaceMarker(place: place)
                marker.map = self.mapView
            }
        }
    }
    
    @IBAction func refreshPlaces(sender: AnyObject) {
        fetchNearbyPlaces(mapView.camera.target)
    }
    
    @IBAction func mapToDetailView(sender: AnyObject) {
        self.performSegueWithIdentifier("MapToDetailViewSegue", sender: sender)
    }
    
    
    @IBAction func directionsFromMap(sender: AnyObject){
        directionsToLocation()
    }
    
    func directionsToLocation() {
        
        guard let latitude = googlePlace?.coordinate.latitude else { return }
        guard let longtitude = googlePlace?.coordinate.longitude else { return}
        let url: String =  "comgooglemaps://?saddr=&daddr=\(latitude),\(longtitude)&directionsmode=driving"
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        } else {
            NSLog("Can't use comgooglemaps://");
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MapToDetailViewSegue"
        {
            if let destinationVC = segue.destinationViewController as? DetailPlaceTableViewController {
                destinationVC.detailPlace = googlePlace
            }
        }
    }
}

// MARK: - SearchesTableViewControllerDelegate
extension PupMapViewController: SearchesTableViewControllerDelegate {
    func searchesController(controller: SearchesTableViewController, didSelectSearch searches: [String]) {
        searchedKeywords = controller.selectedSearches.sort()
        dismissViewControllerAnimated(true, completion: nil)
        fetchNearbyPlaces(mapView.camera.target)
    }
}

// MARK: - CLLocationManagerDelegate
extension PupMapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
            fetchNearbyPlaces(location.coordinate)
        }
    }
}

// MARK: - GMSMapViewDelegate
extension PupMapViewController: GMSMapViewDelegate {
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        
        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(mapView: GMSMapView, willMove gesture: Bool) {
        addressLabel.lock()
        
        if (gesture) {
            mapCenterPinImage.fadeIn(0.25)
            mapView.selectedMarker = nil
            removeButtonsFromScreen()
        }
    }
    
    func mapView(mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        
        let placeMarker = marker as! PlaceMarker
        if let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView {
            
            infoView.nameLabel.text = placeMarker.place.name
            if let photo = placeMarker.place.photo {
                infoView.placePhoto.image = photo
            } else {
                infoView.placePhoto.image = UIImage(named: "Logo")
            }
            
            let googlePlaceInfo = placeMarker.place
            googlePlace = googlePlaceInfo
            
            let seconds = 0.25
            let delay = seconds * Double(NSEC_PER_SEC)
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.detailViewStack.userInteractionEnabled = true
                self.detailButtonOutlet.hidden = false
                self.detailButtonOutlet.enabled = true
                self.directionPathButtonOutlet.hidden = false
                self.directionPathButtonOutlet.enabled = true
            })
            return infoView
        } else {
            return nil
        }
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        mapCenterPinImage.fadeOut(0.25)
        removeButtonsFromScreen()
        return false
    }
    
    func didTapMyLocationButtonForMapView(mapView: GMSMapView) -> Bool {
        mapCenterPinImage.fadeIn(0.25)
        mapView.selectedMarker = nil
        return false
    }
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate: CLLocationCoordinate2D){
        removeButtonsFromScreen()
    }
}