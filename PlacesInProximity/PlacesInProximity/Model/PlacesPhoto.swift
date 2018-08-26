//
//  PlacesPhoto.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation

struct PlacesPhoto: Codable{
    
    var width: Int?
    var height: Int?
    var photoRefKey: String?
    
    init(photoInfo: [String:Any]){
        guard let height = photoInfo[AppConstants.APIConstants.heightKey] as? Int, let width = photoInfo[AppConstants.APIConstants.widthKey] as? Int, let photoRefKey = photoInfo[AppConstants.APIConstants.photoRefKey] as? String else{
            return
        }
        self.width = width
        self.height = height
        self.photoRefKey = photoRefKey
    }
    
    func getPhotoUrl(photoMaxWidth: Int) -> URL?{
        if let refKey = self.photoRefKey{
            return APIService.googlePhotoURL(photoReference: refKey, maxWidth: photoMaxWidth)
        }
        return nil
    }
    
}
