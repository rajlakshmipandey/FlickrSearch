//
//  HomeCoordinatorTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest

@testable import FlickerSearch

class HomeCoordinatorTest: XCTestCase {
    var coordinator: HomeCoordinator?
    
    // Initial Set-ups
    override func setUpWithError() throws {
        guard let app = UIApplication.shared.delegate, let window = app.window else {return}
        coordinator = HomeCoordinator(window ?? UIWindow())
        coordinator?.start()
    }
    
    // Method to test Start
    func testStart() {
        XCTAssertNotNil(coordinator?.navigationController)
        XCTAssertEqual(coordinator?.navigationController?.viewControllers.count, 1)
    }
    
    // Method to test ShowDetail
    func testShowDetail() {
        let image = Image(farm: 1, server: "", secret: "", id: "")
        coordinator?.showImage(image)
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(coordinator?.navigationController?.viewControllers.count, 2)
        }
    }
    
    // Method to test ShowHistory
    func testShowHistory() {
        coordinator?.showSearchHistory()
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(coordinator?.navigationController?.viewControllers.count, 2)
        }
    }
}

