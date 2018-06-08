//
//  CityListViewControllerTest.swift
//  BackbaseTests
//
//  Created by Jide Opeola on 6/8/18.
//  Copyright © 2018 Jide Opeola. All rights reserved.
//

import XCTest
@testable import Backbase

class CityListViewControllerTest: XCTestCase {
    
    func testIsResultValid() {
        let cityListViewController = CityListViewController()
        let str = "a "
        if let filteredList = cityListViewController.filteredListResult(str) {
            for city in filteredList {
                XCTAssertFalse(city.name.hasPrefix(str))
            }
        }
    }
    
}
