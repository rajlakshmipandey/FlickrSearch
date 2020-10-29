//
//  HomeViewModelTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest

@testable import FlickerSearch
class HomeViewModelTest: XCTestCase {
    
    var homeViewModel: HomeViewModel!
    let coordinator = MockHomeCoordinator()
    
    // Initial set ups
    override func setUpWithError() throws {
        let dependency = FlickerSearchDependency.getFlickerService()
        homeViewModel = HomeViewModel(coordinator: coordinator, dependency: dependency)
        homeViewModel.cleanData()
        homeViewModel.getImage(for: "kitten", pageNo: 1)
    }
    
    // Method to test number of sections
    func testNumberOfSections() {
        XCTAssertEqual(homeViewModel!.getNumberOfSections(), 1)
    }
    
    // Method to test number of rows
    func testNumberOfRowsInSection() {
        
        let exp = expectation(description: "Should be able to fetch data with in 2 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(homeViewModel!.getNumberOfRowsInSection(), 20)
        }
    }
    
    // Method to test Photo url
    func testPhotoURL() {
        let exp = expectation(description: "Should be able to fetch data with in 2 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            let photoURLString = homeViewModel!.getPhotoURL(for: 0)
            XCTAssertNotNil(photoURLString)
        }
    }
    
    // Method to test Show detail
    func testShowDetail() {
        let exp = expectation(description: "Should be able to fetch data with in 2 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        if result == XCTWaiter.Result.timedOut {
            homeViewModel.showDetail(for: 0)
            XCTAssertEqual(coordinator.isDetailShown, true)
        }
    }
    
    // Method to test History
    func testHistory() {
        homeViewModel.getSearchHistory()
        XCTAssertEqual(coordinator.isSearchHistoryShown, true)
    }
    
    // Method to test GetPaging
    func testGetPageNumber() {
        let exp = expectation(description: "Should be able to fetch data with in 2 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(homeViewModel.getPageNumber(), 1)
        }
    }
    
    // Method to get totals
    func testGetTotalNumbetOfImages()  {
        let exp = expectation(description: "Should be able to fetch data with in 1 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(homeViewModel.getTotalNumbetOfImages())
        }
    }
    
    // Method to test Load more data
    func testLoadMoreImages() {
        homeViewModel.cleanData()
        homeViewModel.loadMoreImages(for: "kitten", pageNo: 1)
        let exp = expectation(description: "Should be able to fetch data with in 1 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(homeViewModel!.getNumberOfRowsInSection(), 40)
        }
    }
    
}
