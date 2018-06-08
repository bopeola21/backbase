//
//  Cities.swift
//  Backbase
//
//  Created by Jide Opeola on 6/7/18.
//  Copyright © 2018 Jide Opeola. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class City: NSObject {
    
    @objc var name: String!
    @objc var country: String!
    var id: Int!
    var coordinate: CLLocationCoordinate2D!

    init?(dict: [String : AnyObject]) {
        guard let name = dict["name"] as? String,
            let country = dict["country"] as? String,
            let id = dict["_id"] as? Int,
            let coord = dict["coord"] as? [String : Double] else {
            return nil
        }
        
        self.name = name
        self.country = country
        self.id = id
        
        if let lat = coord["lat"],
            let long = coord["lon"] {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            return nil
        }
    }
}

extension City: Comparable {
    static func ==(lhs: City, rhs: City) -> Bool {
        return (lhs.name, lhs.country) == (rhs.name, rhs.country)
    }
    
    static func < (lhs: City, rhs: City) -> Bool {
        return (lhs.name, lhs.country) < (rhs.name, rhs.country)
    }
}
