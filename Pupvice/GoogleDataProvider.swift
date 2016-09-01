//
//  GoogleData.swift
//  Pupvice
//
//  Created by Chris Yoo on 8/30/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class GoogleDataProvider {
    var photoCache = [String:UIImage]()
    var googlePlace: GooglePlace?
    var placesTask: NSURLSessionDataTask?
    var session: NSURLSession {
        return NSURLSession.sharedSession()
    }
    
    func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D, radius: Double, keywords:[String], completion: (([GooglePlace]) -> Void)) -> ()
    {
        var urlString = "http://localhost:10000/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&rankby=prominence&sensor=true&type=park"
        let keywordsString = keywords.count > 0 ? keywords.joinWithSeparator("|") : "dog park"
        urlString += "&keyword=\(keywordsString)"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        if let task = placesTask where task.taskIdentifier > 0 && task.state == .Running {
            task.cancel()
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        placesTask = session.dataTaskWithURL(NSURL(string: urlString)!) {data, response, error in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            var placesArray = [GooglePlace]()
            if let aData = data {
                let json = JSON(data:aData, options:NSJSONReadingOptions.MutableContainers, error:nil)
                if let results = json["results"].arrayObject as? [[String : AnyObject]] {
                    for rawPlace in results {
                        let place = GooglePlace(dictionary: rawPlace, acceptedKeywords: keywords)
                        placesArray.append(place)
                        if let reference = place.photoReference {
                            self.fetchPhotoFromReference(reference) { image in
                                place.photo = image
                            }
                        }
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                completion(placesArray)
            }
        }
        placesTask?.resume()
    }
    
    
    func fetchPhotoFromReference(reference: String, completion: ((UIImage?) -> Void)) -> () {
        if let photo = photoCache[reference] as UIImage? {
            completion(photo)
        } else {
            let urlString = "http://localhost:10000/maps/api/place/photo?maxwidth=200&photoreference=\(reference)"
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            session.downloadTaskWithURL(NSURL(string: urlString)!) {url, response, error in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if let url = url {
                    let downloadedPhoto = UIImage(data: NSData(contentsOfURL: url)!)
                    self.photoCache[reference] = downloadedPhoto
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(downloadedPhoto)
                    }
                }
                else {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(nil)
                    }
                }
                }.resume()
        }
    }
    
    func fetchReviewFromPlaceID(placeID: String) -> ()
    {
        let googleMapsApiKey = "AIzaSyAzpVdtLbbRYJb-Ia79HxZB1qzZS17wj5I"
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=\(googleMapsApiKey)"
        if let task = placesTask where task.taskIdentifier > 0 && task.state == .Running {
            task.cancel()
        }
        
        //https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJN1t_tDeuEmsRUsoyG83frY4&key=AIzaSyAzpVdtLbbRYJb-Ia79HxZB1qzZS17wj5I
        
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        placesTask = session.dataTaskWithURL(url) {data, response, error in
            print(data)
            print(response)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            var placeDetailArray = [GoogleDetails]()
            if let aData = data {
                let json = JSON(data:aData, options:NSJSONReadingOptions.MutableContainers, error:nil)
                print(json)
                if let results = json["results"].arrayObject as? [[String : AnyObject]] {
                    for rawPlace in results {
                        let placeDetail = GoogleDetails(dictionary: rawPlace)
                        placeDetailArray.append(placeDetail)
                    }
                }
            }
        }
        placesTask?.resume()
    }
}
