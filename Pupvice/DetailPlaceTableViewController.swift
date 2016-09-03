//
//  DetailPlaceTableViewController.swift
//  Pupvice
//
//  Created by Chris Yoo on 9/2/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit

class DetailPlaceTableViewController: UITableViewController {
    
    var detailPlace: GooglePlace?
    let dataProvider = GoogleDataProvider()
    
    var placesArray: [GoogleDetails] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
        if let detailPlace = detailPlace {
            DetailPlaceModelController.sharedController.fetchDetailPlace(detailPlace.placeID, completion: { (reviews) in
                self.placesArray = reviews
                self.tableView.reloadData()
            })
        }
        
        print(detailPlace?.placeID)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailPlace = detailPlace else { return }
        
        nameLabel.text = "   \(detailPlace.name)"
        ratingLabel.text = "    Rated: \(detailPlace.rating)"
        locationLabel.text = "    Location: \(detailPlace.address)"
        imageView.image = detailPlace.photo
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
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
    
    
    
}
