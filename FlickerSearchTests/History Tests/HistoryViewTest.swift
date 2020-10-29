//
//  HistoryViewTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch


class HistoryViewTest: XCTestCase {
    
    var historyView: HistoryView?
    var historyViewModel: HistoryViewModel?
    
    // Initial setups
    override func setUpWithError() throws {
        historyView = Views.history.view as? HistoryView
        historyViewModel = HistoryViewModel()
        historyView?.viewModel = historyViewModel
        historyViewModel?.historyResult = historyView
        historyView?.loadView()
        historyView?.viewDidLoad()
        historyView?.viewWillAppear(true)
    }
    
    // Method to test number of row
    func testNumberOfRows(){
        let tableView = historyView?.tableView
        XCTAssertEqual(historyViewModel?.getNumberOfRowsInSection(),tableView?.dataSource?.tableView(tableView ?? UITableView(), numberOfRowsInSection: 0))
    }
    
    // Method to test number of section
    func testNumberOfSection(){
        let tableView = historyView?.tableView
        XCTAssertEqual(historyViewModel?.getNumberOfSections(),tableView?.dataSource?.numberOfSections?(in: tableView ?? UITableView()))
    }
    
    // Method to test table view cell
    func testTableViewCell() {
        let indexPath = IndexPath(row: 0, section: 0)
        let tableView = historyView?.tableView
        let cell = tableView?.dataSource?.tableView(tableView ?? UITableView(), cellForRowAt: indexPath)
        let cellReuseIdentifierIdentifer = cell?.reuseIdentifier
        let expectedCellReuseIdentifier = Cell.history
        XCTAssertEqual(cellReuseIdentifierIdentifer, expectedCellReuseIdentifier)
    }
    
    // Method to test display
    func testDisplay() {
        historyViewModel?.historyResult?.showResult()
        let tableView = historyView?.tableView
        XCTAssertEqual(historyViewModel?.getNumberOfRowsInSection(),tableView?.dataSource?.tableView(tableView ?? UITableView(), numberOfRowsInSection: 0))
    }
    
    // Method to test display error
    func testDisplayError() {
        historyViewModel?.historyResult?.showError(error: NetworkError.failed)
        let nav = UINavigationController.init(rootViewController: historyView ?? UIViewController())
        let exp = expectation(description: "Test after 2 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 2)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(nav.visibleViewController is UIAlertController)
        }
    }
    
    // Method to test height ofr row
    func testHeightForRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        let tableView = historyView?.tableView
        XCTAssertEqual(tableView?.delegate?.tableView?(tableView ?? UITableView(), heightForRowAt: indexPath),  historyViewModel?.getHeightForRow())
    }
    
    
    
    
}
