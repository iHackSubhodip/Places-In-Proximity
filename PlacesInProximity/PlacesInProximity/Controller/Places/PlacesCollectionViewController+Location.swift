//
//  PlacesCollectionViewController+Location.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 26/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import CoreLocation

extension PlacesCollectionViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let userLocation:CLLocation = locations[0] as CLLocation
        presentLocation = userLocation.coordinate
        loadPlacesInProximity(true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        AppUtility.errorGettingCurrentLocation(errorMessage: error.localizedDescription, view: self)
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager?.startUpdatingLocation()
        } else if status == .denied || status == .restricted {
            AppUtility.errorGettingCurrentLocation(errorMessage: "Location access denied", view: self)
        }
    }
}
