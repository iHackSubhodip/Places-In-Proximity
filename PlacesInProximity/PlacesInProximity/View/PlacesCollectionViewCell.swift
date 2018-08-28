//
//  PlacesCollectionViewCell.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import AlamofireImage

class PlacesCollectionViewCell: UICollectionViewCell {
    
    var place: Places?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var placesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
    }
    
    func update(place:Places) {
        self.place = place
        placesLabel.text = place.getDescription()
    }
    
}
