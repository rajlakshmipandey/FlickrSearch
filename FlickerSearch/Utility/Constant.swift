//
//  Constant.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation
import UIKit

// Storyboard identifier
struct Storyboard {
    static let home = "HomeView"
    static let imageDetail = "ImageDetail"
    static let history = "HistoryView"
}

struct Cell {
    static let history = "HistoryCell"
    static let collectionCell = "ImageCell"
}

struct Title {
    static let history = "History"
    static let home = "Flicker Search"
    static let image = "Image"
    static let searchText = "Search images here"
    
}

struct Default {
    static let historyFileName = "SearchedHistory"
    static let pageNo = 1
}

struct CollectionItem {
    static let spacing: CGFloat = 10.0
    static let itemsPerRow: CGFloat = 2.0
    static let insets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
}

struct ErrorMsg {
    static let errorTitle = "Error"
    static let ok = "OK"
}

struct ImageSize {
    static let medium = "m"
    static let large = "b"
}


struct CellDefaults {
    static let forSection = 1
    static let forRowHeight: CGFloat = 44.0
    static let emptySearchText = 0
}

struct ImageConstant {
    static let defaultImage = UIImage(named: "DefaultImage")
}
