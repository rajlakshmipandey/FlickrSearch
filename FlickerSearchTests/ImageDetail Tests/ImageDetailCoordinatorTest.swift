//
//  ImageDetailCoordinatorTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch

class ImageDetailCoordinatorTest: XCTestCase {
    
    // Properties
    var coordinator: ImageDetailCoordinator?
    
    // Initial setups
    override func setUpWithError() throws {
        let image =  Image(farm: 66, server: "65535", secret: "32765675e7", id: "50488323372")
        guard let app = UIApplication.shared.delegate, let window = app.window else {return}
        let imageDetail = Views.imageDetail.view as? ImageDetailView
        let navigationController = UINavigationController(rootViewController: imageDetail ?? UIViewController())
        window?.rootViewController = navigationController
        coordinator = ImageDetailCoordinator(navigationController, imageData: image)
    }
    
    
    // Method to test coordinator start
    func testStart() {
        coordinator?.start()
        XCTAssertNotNil(coordinator?.navigationController)
        XCTAssertEqual(coordinator?.navigationController?.viewControllers.count, 1)
    }
}
