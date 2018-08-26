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
}

extension PlacesCategory: ExpressibleByStringLiteral{
    
    init(stringLiteral value: String){
        self.name = value
    }
}
