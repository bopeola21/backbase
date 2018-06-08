//
//  CityMapViewController.swift
//  Backbase
//
//  Created by Jide Opeola on 6/7/18.
//  Copyright © 2018 Jide Opeola. All rights reserved.
//

import UIKit
import MapKit

class CityMapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(city.name!), \(city.country!)"
        mapView.centerCoordinate = city.coordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = city.coordinate
        mapView.addAnnotation(annotation)
    }
}
