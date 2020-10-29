//
//  NetworkServiceTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch


class NetworkServiceTest: XCTestCase {
    
    var dependency: DependencyProtocol?
    
    override func setUpWithError() throws {
        dependency = FlickerSearchDependency.getFlickerService()
    }
    
    // API interaction asynchronus test
    func testAPIData() {
        let networkExpectation = expectation(description: "Data retrived from API")
        dependency?.fetchData(for: FlickerSearchAPI.photos(searchText: "kitten", pageNo: 1), completion: { result, error in
            networkExpectation.fulfill()
            XCTAssertNil(error)
            XCTAssertNotNil(result)
        })
        
        wait(for: [networkExpectation], timeout: 3.0)
    }
    
    // To test error scenario
    func testAPIError() {
        let errorExpectation = expectation(description: "Data is received Successfully")
        dependency?.fetchData(for: FlickerSearchAPI.photos(searchText: "", pageNo: 0), completion: { photoResult, error in
            errorExpectation.fulfill()
            XCTAssertNotNil(error)
        })
        
        wait(for: [errorExpectation], timeout: 3.0)
    }
    
}
