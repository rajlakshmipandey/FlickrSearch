//
//  HistoryViewModel.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit


class HistoryViewModel : HistoryViewModelProtocol {
    
    //MARK: Properties
    private var searchedStrings: [String]?
    weak var historyResult : HistoryResultProtocol?
    
    
    //MARK: HistoryViewModelProtocol methods
    func getNumberOfRowsInSection() -> Int {
        return searchedStrings?.count ?? 0
    }
    
    
    // To return number of sections for tableview
    func getNumberOfSections() -> Int {
        return CellDefaults.forSection
    }
    
    
    // Method to be used to receive searched text for row
    func getSearchedString(row: Int) -> String {
        return searchedStrings?[row] ?? ""
    }
    
    
    // To return height for row
    func getHeightForRow() -> CGFloat {
        return CellDefaults.forRowHeight
    }
    
    
    // Method to be used to fetch data from the disc
    func getDataFromDisk(for fileName: String = Default.historyFileName) {
        guard let historyData = FileHandler.getDataFromFile(fileName: fileName, to: [String].self) else {
            historyResult?.showError(error: NetworkError.noResult)
            return
        }
        searchedStrings = historyData.reversed()
        historyResult?.showResult()
    }
    
}
