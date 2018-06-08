//
//  Model.swift
//  Backbase
//
//  Created by Jide Opeola on 6/7/18.
//  Copyright © 2018 Jide Opeola. All rights reserved.
//

import Foundation
import UIKit

final class Model {
    
    private init() {
        cities = fetchCities()
    }
    
    static let shared = Model()
    
    var cities: [City]?
    
    func fetchCities() -> [City]? {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String : AnyObject]] {
                    let cities = jsonResult.compactMap{City(dict: $0)}
                    
                    // used NSSortDescriptor instead of Comparable because it is faster
                    let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)
                    let sortDescriptor2 = NSSortDescriptor(key: "country", ascending: true)
                    let sortedArray = (cities as NSArray).sortedArray(using: [sortDescriptor1, sortDescriptor2]) as? [City]
                    
                    return sortedArray
                }
            } catch {
                // handle error
            }
        }
        
        return nil
    }    
}
