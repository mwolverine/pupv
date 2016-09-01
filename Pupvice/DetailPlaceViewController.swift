//
//  DetailPlaceViewController.swift
//  Pupvice
//
//  Created by Chris Yoo on 8/31/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit

class DetailPlaceViewController: UIViewController {
    
    var detailPlace: GooglePlace!
    var detailSpecfic: GoogleDetails?
    let dataProvider = GoogleDataProvider()

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailPlace()
        nameLabel.text = detailPlace.name
        locationLabel.text = detailPlace.address
        ratingLabel.text = detailSpecfic?.text
        imageView.image = detailPlace.photo
        costLabel.text = detailPlace.rating
        typeLabel.text = detailPlace.phoneNumber

        // Do any additional setup after loading the view.
    }
    
    func fetchDetailPlace() {
        let placeID = detailPlace.placeID
        dataProvider.fetchReviewFromPlaceID(placeID)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
