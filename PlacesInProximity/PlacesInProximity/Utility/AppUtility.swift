//
//  AppUtility.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation

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
    }
    
    struct APIEndPoint{
        static let searchApiHost = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        static let googlePhotosHost = "https://maps.googleapis.com/maps/api/place/photo"
    }
    
    struct PhotoWidth{
        static let maxWidth = 600
    }
    
}

