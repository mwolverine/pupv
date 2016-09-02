//
//  DetailPlaceTableViewController.swift
//  Pupvice
//
//  Created by Chris Yoo on 9/2/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit

class DetailPlaceTableViewController: UITableViewController {

    var detailPlace: GooglePlace!
    let dataProvider = GoogleDataProvider()
    var placesDetailArray: [GoogleDetails] = []
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        nameLabel.text = detailPlace.name
        locationLabel.text = detailPlace.address
        imageView.image = detailPlace.photo
        costLabel.text = detailPlace.rating
        typeLabel.text = detailPlace.phoneNumber
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let placeID = detailPlace.placeID
        DetailPlaceModelController.sharedController.fetchDetailPlace(placeID) {
        }
        return DetailPlaceModelController.sharedController.placesDetailArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewsCell", forIndexPath: indexPath) as? DetailPlaceTableViewCell
        let placeDetail = DetailPlaceModelController.sharedController.placesDetailArray[indexPath.row]
        cell?.reviewLabel.text = placeDetail.text
        cell?.ratingLabel.text = placeDetail.rating
        return cell ?? UITableViewCell()
    }



}
