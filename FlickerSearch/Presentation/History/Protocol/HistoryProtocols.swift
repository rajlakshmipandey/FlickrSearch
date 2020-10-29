//
//  HistoryProtocols.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit

protocol HistoryViewModelProtocol {
    
    // Protocol methods
    func getSearchedString(row:Int) -> String
    func getNumberOfRowsInSection() -> Int
    func getNumberOfSections() -> Int
    func getHeightForRow() -> CGFloat
}


protocol HistoryResultProtocol: class {
    
    // Protocol methods
    func showResult()
    func showError(error: NetworkError)
}
