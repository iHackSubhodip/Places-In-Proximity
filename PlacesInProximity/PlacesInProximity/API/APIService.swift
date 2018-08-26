//
//  APIService.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire

class APIService{
    
    static func googlePhotoURL(photoReference:String, maxWidth:Int) -> URL? {
        return URL.init(string: "\(AppConstants.APIEndPoint.searchApiHost)?maxwidth=\(maxWidth)&key=\(AppDelegate.palcesAPIKey)&photoreference=\(photoReference)")
    }
    
    static func getNearbyPlaces(by category:String, coordinates:CLLocationCoordinate2D, radius:Int, token: String?, completion: @escaping (PlacesResponse?) -> Void) {
        
        var params : [String : Any]
        
        if let t = token {
            params = [
                "key" : AppDelegate.palcesAPIKey,
                "pagetoken" : t,
            ]
        } else {
            params = [
                "key" : AppDelegate.palcesAPIKey,
                "radius" : radius,
                "location" : "\(coordinates.latitude),\(coordinates.longitude)",
                "type" : category.lowercased()
            ]
        }
        
        
        Alamofire.request(AppConstants.APIEndPoint.searchApiHost, parameters: params, encoding: URLEncoding(destination: .queryString)).responseJSON { response in
            
            if let error = response.error {
                print("Failed to connect --- \(error)")
                return
            }
            
            guard let data = response.result.value as? [String: Any] else { return }
            
            let response = PlacesResponse.init(infoDictionary: data)
            completion(response)
        }
    }
    
    
}
