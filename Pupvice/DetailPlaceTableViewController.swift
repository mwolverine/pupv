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
    
    var imageSliderVC: TNImageSliderViewController!
    
    var detailPlace: GooglePlace?
    let dataProvider = GoogleDataProvider()
    
    var placesArray: [GoogleDetails] = []
    var photosArray: [GoogleDetailsPhoto] = []
    var imagesArray: [UIImage] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        
        if let detailPlace = detailPlace {
            let placeID = detailPlace.placeID
            DetailPlaceModelController.sharedController.fetchDetailPlace(placeID, completion: { (reviews, photos) in
                self.placesArray = reviews
                self.photosArray = photos
                
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "LogoWithName")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        guard let detailPlace = detailPlace else { return }
        
        nameLabel.text = "   \(detailPlace.name)"
        ratingLabel.text = "    Rated: \(detailPlace.rating)"
        locationLabel.text = "    Location: \(detailPlace.address)"
        // imageView.image = detailPlace.photo
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        let notification = NSNotificationCenter.defaultCenter()
        
        notification.addObserver(self, selector: #selector(setImages), name: notificationName, object: nil)
    }
    
    func setImages() {
        let imageReferences = GoogleDataProvider.photosPlacesDetailArray
        //bit slow //show but takes time
        if imageReferences.count == 0 {
            let image1 = UIImage(named: "noImage")
            if let image1 = image1 {
                self.imageSliderVC.images = [image1] }
        } else {
            DetailPlaceModelController.sharedController.fetchDetailPhoto(imageReferences, completion: { (images) in
                self.imagesArray = DetailPlaceModelController.sharedController.images
                self.imageSlider()
                self.imageSliderVC.images = self.imagesArray
            })
        }
    }

    func imageSlider() {
        
        var options = TNImageSliderViewOptions()
        options.pageControlHidden = false
        options.scrollDirection = .Horizontal
        options.pageControlCurrentIndicatorTintColor = UIColor.yellowColor()
        options.autoSlideIntervalInSeconds = 3
        options.shouldStartFromBeginning = true
        options.imageContentMode = .ScaleAspectFit
        imageSliderVC.options = options
        
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
