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
    var searchedKeywords = ["dog park"]
    var searchedType = ["park"]
    let locationManager = CLLocationManager()
    let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 4000

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "LogoWithName")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Searches Segue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! SearchesTableViewController
            controller.selectedSearches = searchedKeywords
            controller.delegate = self
        }
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
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, keywords: searchedKeywords) { places in
            for place: GooglePlace in places {
                let marker = PlaceMarker(place: place)
                marker.map = self.mapView
            }
        }
    }

    @IBAction func refreshPlaces(sender: AnyObject) {
        fetchNearbyPlaces(mapView.camera.target)
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
        }
    }
    
    func mapView(mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let placeMarker = marker as! PlaceMarker
        
        if let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView {
            infoView.nameLabel.text = placeMarker.place.name
            
            if let photo = placeMarker.place.photo {
                infoView.placePhoto.image = photo
            } else {
                infoView.placePhoto.image = UIImage(named: "generic")
            }
            
            return infoView
        } else {
            return nil
        }
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        mapCenterPinImage.fadeOut(0.25)
        return false
    }
    
    func didTapMyLocationButtonForMapView(mapView: GMSMapView) -> Bool {
        mapCenterPinImage.fadeIn(0.25)
        mapView.selectedMarker = nil
        return false
    }
}