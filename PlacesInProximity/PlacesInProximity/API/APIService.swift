//
//  APIService.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation

class APIService{
    
    static func googlePhotoURL(photoReference:String, maxWidth:Int) -> URL? {
        return URL.init(string: "\(AppConstants.APIEndPoint.searchApiHost)?maxwidth=\(maxWidth)&key=\(AppDelegate.palcesAPIKey)&photoreference=\(photoReference)")
    }
    
}
