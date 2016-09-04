//
//  DetailPlaceTableViewController.swift
//  Pupvice
//
//  Created by Chris Yoo on 9/2/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit
import TNImageSliderViewController

class DetailPlaceTableViewController: UITableViewController {
    
    var detailPlace: GooglePlace?
//    var photoPlaces: GoogleDetailsPhoto?

    let dataProvider = GoogleDataProvider()
    
    var placesArray: [GoogleDetails] = []
    var photosArray: [GoogleDetailsPhoto] = []
//    var photoPlacesArray: [GoogleDetailsPhoto] = []
    var imageSliderVC:TNImageSliderViewController!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
        if let detailPlace = detailPlace {
            DetailPlaceModelController.sharedController.fetchDetailPlace(detailPlace.placeID, completion: { (reviews, photoReferences) in
                self.placesArray = reviews
                self.photosArray = photoReferences
                 self.tableView.reloadData()

            })
            
//            fetchDetailPlace(detailPlace.placeID, completion: { (reviews) in
//                self.placesArray = reviews
//                self.tableView.reloadData()
//            })
        }
        
        print(detailPlace?.placeID)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailPlace = detailPlace else { return }
        
        nameLabel.text = "   \(detailPlace.name)"
        ratingLabel.text = "    Rated: \(detailPlace.rating)"
        locationLabel.text = "    Location: \(detailPlace.address)"
//        imageView.image = detailPlace.photo
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }
    
    
    func imageSlider() {
        
        print("[ViewController] View did load")
        let imageArray: [UIImage?] = DetailPlaceModelController.sharedController.photoPlacesDetailArray

        //let image0 = imageArray.first
        let image1 = imageArray[0]
        let image2 = imageArray[1]
        let image3 = imageArray[2]

        
        if let image1 = image1, let image2 = image2, let image3 = image3
        {
//
//             1. Set the image array with UIImage objects
            imageSliderVC.images = [image1, image2, image3]


            
            // 2. If you want, you can set some options
            var options = TNImageSliderViewOptions()
            options.pageControlHidden = false
            options.scrollDirection = .Horizontal
            options.pageControlCurrentIndicatorTintColor = UIColor.yellowColor()
            options.autoSlideIntervalInSeconds = 2
            options.shouldStartFromBeginning = true
            options.imageContentMode = .ScaleAspectFit
            
            imageSliderVC.options = options
            
        } else {
        
            print("[ViewController] Could not find one of the images in the image catalog")
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return placesArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewsCell", forIndexPath: indexPath) as? DetailPlaceTableViewCell
        let placeDetail = placesArray[indexPath.row]
        
        cell?.reviewLabel.text = placeDetail.text
        cell?.nameLabel.text = placeDetail.authorName
        
        let rating = String(placeDetail.rating)
        let intString = rating.componentsSeparatedByCharactersInSet(
            NSCharacterSet
                .decimalDigitCharacterSet()
                .invertedSet)
            .joinWithSeparator("")
        cell?.ratingLabel.text = "Happy: \(intString)"
        
        return cell ?? UITableViewCell()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("[ViewController] Prepare for segue")
        
        if( segue.identifier == "imageSliderSegue" ){
            
            imageSliderVC = segue.destinationViewController as! TNImageSliderViewController
            
        }
        
    }
    
    
    
    
}
