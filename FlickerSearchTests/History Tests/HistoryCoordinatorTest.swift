//
//  HistoryCoordinatorTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch

class HistoryCoordinatorTest: XCTestCase {
    var coordinator: HistoryCoordinator?
    
    // Initial setups
    override func setUpWithError() throws {
        guard let app = UIApplication.shared.delegate, let window = app.window else {return}
        guard let history = Views.history.view as? HistoryView else { return }
        let navigationController = UINavigationController(rootViewController: history )
        window?.rootViewController = navigationController
        
        coordinator = HistoryCoordinator(navigationController: navigationController)
    }
    
    // Method to test 
    func testStart() {
        coordinator?.start()
        XCTAssertNotNil(coordinator?.navigationController)
        XCTAssertEqual(coordinator?.navigationController?.viewControllers.count, 2)
    }
    
}
