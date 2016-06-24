//
//  CategoryRequestTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 6/24/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class CategoryRequestTests: XCTestCase {
    let returnData = "Test Data"
    
    override func setUp() {
        super.setUp()
        
        BreweryDBApiKey = "testKey"
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testCategoryCanBeInitialized() {
        let request: CategoryRequest? = CategoryRequest()
        XCTAssertNotNil(request)
    }
    
    func testCategoryRequestCanBeDeinitialized() {
        var request: CategoryRequest? = CategoryRequest()
        request = nil
        XCTAssertNil(request)
    }
    
}