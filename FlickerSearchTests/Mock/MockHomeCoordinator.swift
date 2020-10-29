//
//  MockHomeCoordinator.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch

class MockHomeCoordinator: HomeCoordinatorProtocol {
    
    
    var isSearchHistoryShown: Bool = false
    var isDetailShown: Bool = false
    
    // Method to test History screen opened event
    func showSearchHistory() {
        isSearchHistoryShown = true
    }
    
    // Method to test Photo detail screen opened event
    func showImage(_ imageName: Image) {
        isDetailShown = true
    }
}

