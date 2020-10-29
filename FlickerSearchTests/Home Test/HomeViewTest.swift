//
//  HomeViewTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch


class HomeViewTest: XCTestCase {
    
    var homeView: HomeView?
    var viewModel: HomeViewModel?
    var coordinator = MockHomeCoordinator()
    
    // initial set ups
    override func setUpWithError() throws {
        homeView = Views.home.view as? HomeView
        viewModel = HomeViewModel(coordinator: coordinator, dependency: FlickerSearchDependency.getFlickerService())
        homeView?.viewModel = viewModel
        viewModel?.searchResult = homeView
        
        homeView?.loadView()
        homeView?.viewDidLoad()
        
        viewModel?.getImage(for: "kitten", pageNo: 1)
    }
    
    // Method to test instantiate view controller
    func testCanInstantiateViewController() {
        XCTAssertNotNil(homeView)
    }
    
    // Method to test view controller
    func testCollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(homeView?.collectionView)
    }
    
    // Method to test collection view items
    func testHasItemsForCollectionView() {
        XCTAssertNotNil(viewModel?.getNumberOfRowsInSection)
    }
    
    // Method to test number of section
    func testNumberOfSection() {
        XCTAssertNotNil(viewModel?.getNumberOfSections)
    }
    
   
    // Method to test collection view delegate
    func testShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(homeView?.collectionView.delegate)
    }
    
    
    // Method to test tableview cell
    func test_CellData(){
        let exp = expectation(description: "Should be able to fetch data with in 1 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            let indexPath = IndexPath(row: 0, section: 0)
            guard let collectionView = homeView?.collectionView else { return  }
            let cell = homeView?.collectionView?.dataSource?.collectionView(collectionView, cellForItemAt: indexPath)
            let cellReuseIdentifierIdentifer = cell?.reuseIdentifier
            let expectedCellReuseIdentifier = Cell.collectionCell
            XCTAssertEqual(cellReuseIdentifierIdentifer, expectedCellReuseIdentifier)
        }
    }
    
    // Method to test display error
    func testDisplayError() {
        viewModel?.searchResult?.showError(error: .requestError)
        let nav = UINavigationController.init(rootViewController: homeView ?? UIViewController())
        let exp = expectation(description: "Test after 1.5 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(nav.visibleViewController is UIAlertController)
        }
    }
    
    // Method to test default image
    func testDefaultImage() {
        let exp = expectation(description: "Test after 1.5 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.5)
        if result == XCTWaiter.Result.timedOut {
            let indexPath = IndexPath(row: 0, section: 0)
            guard let collectionView = homeView?.collectionView else { return  }
            let cell = homeView?.collectionView?.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) as? ImageCell
            cell?.configure(with: nil)
            XCTAssertNotNil(cell?.imageCell.image)
            
        }
    }
}
