//
//  PlacesResponse.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit

struct PlacesResponse {
    
    var nextPageToken: String?
    var status: String  = AppConstants.APIConstants.notOK
    var places: [Places]?
    
    init?(infoDictionary: [String : Any]?) {
        nextPageToken = infoDictionary?[AppConstants.APIConstants.nextToken] as? String
        
        if let status = infoDictionary?[AppConstants.APIConstants.status] as? String {
            self.status = status
        }
        
        if let results = infoDictionary?[AppConstants.APIConstants.result] as? [[String : Any]]{
            var places = [Places]()
            for place in results {
                places.append(Places.init(infoDictionary: place))
            }
            self.places = places
        }
    }
    
    func canLoadMore() -> Bool {
        if status == AppConstants.APIConstants.ok && nextPageToken != nil && nextPageToken?.count ?? 0 > 0 {
            return true
        }
        return false
    }
}

