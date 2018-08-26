//
//  PlacesCategory.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation

struct PlacesCategory{
    
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    var views:Int {
        get {
            return UserDefaults.standard.integer(forKey: AppConstants.APIConstants.setPrefix + name)
        }
    }
    
    func markView() {
        UserDefaults.standard.set(views + 1, forKey: AppConstants.APIConstants.setPrefix + name)
    }
    
}

extension PlacesCategory: ExpressibleByStringLiteral{
    
    init(stringLiteral value: String){
        self.name = value
    }
}

extension PlacesCategory {
    
    
    
}
