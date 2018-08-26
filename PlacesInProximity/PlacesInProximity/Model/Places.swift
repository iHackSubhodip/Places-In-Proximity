//
//  Places.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class Places: NSObject{
    
    var locationValue: CLLocationCoordinate2D?
    var name: String?
    var placeID: String?
    var photos: [PlacesPhoto]?
    var vicinity: String?
    var isOpen: Bool?
    var types: [String]?
    var result: [String: Any]?
    
    init(infoDictionary: [String: Any]){
        guard let placeID = infoDictionary[AppConstants.APIConstants.placeID] as? String, let name = infoDictionary[AppConstants.APIConstants.nameKey] as? String, let types = infoDictionary[AppConstants.APIConstants.typesKey] as? [String], let vicinity = infoDictionary[AppConstants.APIConstants.vicinityKey] as? String else{
            return
        }
        
        if let openingHours = infoDictionary[AppConstants.APIConstants.openingHoursKey] as? [String:Any] {
            if let isOpen = openingHours[AppConstants.APIConstants.openNowKey] as? Bool {
                self.isOpen = isOpen
            }
        }
        
        if let geoKey = infoDictionary[AppConstants.APIConstants.geometryKey] as? [String:Any] {
            if let location = geoKey[AppConstants.APIConstants.locationKey] as? [String:Double] {
                if let lat = location[AppConstants.APIConstants.latitudeKey], let lng = location[AppConstants.APIConstants.longitudeKey] {
                    self.locationValue = CLLocationCoordinate2D.init(latitude: lat, longitude: lng)
                }
            }
        }
        photos = [PlacesPhoto]()
        
        if let photosKey = infoDictionary[AppConstants.APIConstants.photosKey] as? [[String:Any]] {
            for photo in photosKey {
                self.photos?.append(PlacesPhoto.init(photoInfo: photo))
            }
        }
        
        self.placeID = placeID
        self.name = name
        self.types = types
        self.vicinity = vicinity
    }
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let desc = getDescription()
        let rect = NSString(string: desc).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func getDescription() -> String {
        
        var subHeader : [String] = []
        
        if let name = name {
            subHeader.append("Name: \(name)")
        }
        
        if let vicinity = vicinity {
            subHeader.append("Vicinity: \(vicinity)")
        }
        
        if let types = types {
            subHeader.append("Types: \(types.joined(separator: ", "))")
        }
        
        if let isOpen = isOpen {
            subHeader.append(isOpen ? "OPEN NOW" : "CLOSED NOW")
        }
        
        return subHeader.joined(separator: "\n")
    }
    
}
