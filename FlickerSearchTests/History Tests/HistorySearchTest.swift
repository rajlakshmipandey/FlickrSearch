//
//  HistorySearchTest.swift
//  FlickerSearchTests
//
//  Created by Rajlakshmi on 10/28/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import XCTest
@testable import FlickerSearch

// This class is used to test HomeViewModel.

class HistorySearchTest: XCTestCase {
    
    // Properties
    var historyViewModel: HistoryViewModel!
    var dataManager: FileHandler!
    var historyData: [String]?
    
    // Initial setups
    override func setUpWithError() throws {
        historyViewModel =  HistoryViewModel()
        dataManager = FileHandler()
        historyViewModel.getDataFromDisk(for: "")
        XCTAssertEqual(historyViewModel.getNumberOfRowsInSection(), 0)
        historyData = FileHandler.getDataFromFile(fileName: Default.historyFileName, to: [String].self)?.reversed()
        historyViewModel.getDataFromDisk()
    }
    
    // Method to test history detail
    func testGetHistory() {
        historyViewModel.getDataFromDisk()
        let numberOfRows: Int = historyViewModel.getNumberOfRowsInSection()
        if historyData != nil {
            XCTAssertEqual(numberOfRows, historyData?.count)
        }
    }
    
    // Method to test number of row
    func testNumberOfRowsInSection() {
        if historyData != nil {
            XCTAssertEqual(historyViewModel.getNumberOfRowsInSection(), historyData?.count)
        }
        
    }
    
    // Method to test number of section
    func testNumberOfSections() {
        XCTAssertEqual(historyViewModel.getNumberOfSections(), 1)
    }
    
    // Method to test searched text
    func testSearchedText() {
        if historyData != nil {
            XCTAssertEqual(historyViewModel.getSearchedString(row: 0), historyData?[0])
        }
    }
    
    // Method to test height for row
    func testHeightForRow() {
        XCTAssertEqual(historyViewModel.getHeightForRow(), CellDefaults.forRowHeight)
    }
    
    
    
}
