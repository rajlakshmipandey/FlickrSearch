//
//  ImageDetailViewModelTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch

class ImageDetailViewModelTest: XCTestCase {
    
    // Properties
    var imageDetailViewModel: ImageDetailViewModel?
    
    // Initial setups
    override func setUpWithError() throws {
        let image =  Image(farm: 20, server: "2345", secret: "34567890e7", id: "23456789")
        imageDetailViewModel = ImageDetailViewModel(image: image)
    }
    
    // Method to test photo url string
    func testPhotoUrlString() {
        let imageUrl = imageDetailViewModel?.getImageUrl()
        XCTAssertEqual(imageUrl, "https://farm20.staticflickr.com/2345/23456789_34567890e7_b.jpg")
    }
}
