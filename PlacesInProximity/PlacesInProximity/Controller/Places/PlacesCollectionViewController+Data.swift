//
//  PlacesCollectionViewController+Data.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 27/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit

extension PlacesCollectionViewController{
    
    func loadPlacesInProximity(_ force:Bool) {
        APIService.getNearbyPlaces(by: category?.name ?? "airport", coordinates: presentLocation!, radius: radius, token: self.response?.nextPageToken, completion: didReceiveResponse)
    
    }
    
    func didReceiveResponse(response:PlacesResponse?) -> Void {
        activityIndicatorView.stopAnimating()
        self.response = response
        if response?.status == AppConstants.APIConstants.ok {
            
            if let p = response?.places {
                places.append(contentsOf: p)
            }
            
            self.collectionView?.reloadData()
        } else {
            let alert = UIAlertController.init(title: "Error", message: response?.status.description, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction.init(title: "Retry", style: .default, handler: { (action) in
                self.activityIndicatorView.startAnimating()
                self.loadPlacesInProximity(true)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
