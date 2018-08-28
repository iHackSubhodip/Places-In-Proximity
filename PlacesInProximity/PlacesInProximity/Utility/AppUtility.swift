//
//  AppUtility.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants{
    
    struct APIConstants{
        static let result = "results"
        static let placeID = "place_id"
        static let geometryKey = "geometry"
        static let locationKey = "location"
        static let latitudeKey = "lat"
        static let longitudeKey = "lng"
        static let nameKey = "name"
        static let openingHoursKey = "opening_hours"
        static let openNowKey = "open_now"
        static let vicinityKey = "vicinity"
        static let typesKey = "types"
        static let photosKey = "photos"
        static let widthKey = "width"
        static let heightKey = "height"
        static let photoRefKey = "photo_reference"
        static let setPrefix = "category-"
        static let notOK = "NOK"
        static let ok = "OK"
        static let status = "status"
        static let nextToken = "next_page_token"
    }
    
    struct APIEndPoint{
        static let searchApiHost = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    }
    
    struct PhotoWidth{
        static let maxWidth = 600
    }
    
    struct SegueIdentifier{
        static let mapSegueIdentifier = "searchMaps"
        static let categorySegueIdentifier = "searchCategory"
    }
    
}

final class AppUtility{
    
    static func errorGettingCurrentLocation(errorMessage:String, view:UIViewController) {
        let alert = UIAlertController.init(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        view.parent?.present(alert, animated: true, completion: nil)
        
    }
}
