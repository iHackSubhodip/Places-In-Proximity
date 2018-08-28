//
//  AppDelegate.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import GoogleMaps
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let mapsAPIKey = "AIzaSyC1G9DGJ_p420G5Rwl_P_AyApNC2hvgnD4"
    static let palcesAPIKey = "AIzaSyD3lzXUiOFBDbqCIKoLqdhSp0-fBTfxcDY"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey(AppDelegate.mapsAPIKey)
        return true
    }    
}

