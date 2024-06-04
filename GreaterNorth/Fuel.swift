//
//  Fuel.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 29/08/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
class Fuel {
    
    //MARK: Properties
    
    var name: String
    var gallons: String
    var miles: String
    var cost: String
    
    
    init?(name: String, gallons: String, miles: String, cost: String) {
               
        // Initialize stored properties.
        self.name = name
        self.gallons = gallons
        self.miles = miles
        self.cost = cost
    }
}
