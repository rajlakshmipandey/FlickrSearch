//
//  ImageDetailTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch
class ImageDetailTest: XCTestCase {
    
    // Properties
    var imageDetail: ImageDetailView?
    var imageDetailViewModel: ImageDetailViewModel?
    
    // Initial setups
    override func setUpWithError() throws {
        imageDetail = Views.imageDetail.view as? ImageDetailView
        
        let image =  Image(farm: 66, server: "65535", secret: "32765675e7", id: "50488323372")
        imageDetailViewModel = ImageDetailViewModel(image: image)
        imageDetail?.viewModel = imageDetailViewModel
        imageDetail?.loadView()
        imageDetail?.viewDidLoad()
    }
    
    // Method to test enlarge image
    func testImage() {
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(imageDetail?.image.image)
        }
    }
}
