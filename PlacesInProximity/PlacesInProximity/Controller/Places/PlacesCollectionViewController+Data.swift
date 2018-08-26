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
    
    func canLoadMore() -> Bool {
        if isLoading {
            return false
        }
        
        if let response = self.response {
            if (!response.canLoadMore()) {
                return false
            }
        }
        
        return true
    }
    
    func loadPlacesInProximity(_ force:Bool) {
        
        if !force {
            if !canLoadMore() {
                return
            }
        }
        isLoading = true
        APIService.getNearbyPlaces(by: category?.name ?? "airport", coordinates: presentLocation!, radius: radius, token: self.response?.nextPageToken, completion: didReceiveResponse)
    
    }
    
    func didReceiveResponse(response:PlacesResponse?) -> Void {
        self.response = response
        if response?.status == AppConstants.APIConstants.ok {
            
            if let p = response?.places {
                places.append(contentsOf: p)
            }
            
            self.collectionView?.reloadData()
        } else {
            //optimize the code
            let alert = UIAlertController.init(title: "Error", message: response?.status.description, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction.init(title: "Retry", style: .default, handler: { (action) in
                self.loadPlacesInProximity(true)
            }))
            present(alert, animated: true, completion: nil)
        }
        isLoading = false
    }
    
}
