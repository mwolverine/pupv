//
//  MarkerView.swift
//  Pupvice
//
//  Created by Chris Yoo on 8/30/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//

import UIKit

class MarkerInfoView: UIView {
    
    
    weak var delegate: detailButtonTouchedDelegate?
      
    @IBOutlet weak var placePhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func detailButtonTouched(sender: AnyObject) {
        userInteractionEnabled = true
        if let delegate = delegate {
            delegate.detailButtonTouched(self)
        }
    }
}

protocol detailButtonTouchedDelegate: class {
    func detailButtonTouched(sender: MarkerInfoView)
}