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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placesLabel: UILabel!
    
    func update(place:Places) {
        self.place = place
        placesLabel.text = place.getDescription()
        imageView.image = nil
        
        if let url = place.photos?.first?.getPhotoUrl(photoMaxWidth: AppConstants.PhotoWidth.maxWidth) {
            imageView.af_setImage(withURL: url)
        }
//        else{
//            imageView.image = UIImage.init(named: "default_image")
//        }
    }
    
}
