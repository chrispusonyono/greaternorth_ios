//
//  Pickup.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 30/08/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
class Pickup {
    
    //MARK: Properties
    
    var id: String
    var mobile: String
    var name: String
    var location: String
    var destination: String
    var time: String
    var dtime: String
    var status: String
    var showIn: String
    var locationCity: String
    var destinationCity: String
    var destinationNumber: String
    
    
    init?(id: String, mobile: String, name: String, location: String, destination: String, time: String, dtime: String, status: String, showIn: String, locationCity: String, destinationCity: String, destinationNumber: String) {
        self.id=id
        self.mobile=mobile
        self.name=name
        self.location=location
        self.destination=destination
        self.time=time
        self.dtime=dtime
        self.status=status
        self.showIn=showIn
        self.locationCity=locationCity
        self.destinationCity=destinationCity
        self.destinationNumber=destinationNumber
    }
}
