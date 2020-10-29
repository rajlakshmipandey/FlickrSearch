//
//  VIews.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit

enum Views {
    case home
    case imageDetail
    case history
    
    // View controllers 
    var view: UIViewController? {
        switch self {
        case .home:
            let storyboard = UIStoryboard(name: Storyboard.home, bundle: nil)
            let home = storyboard.instantiateViewController(withIdentifier: Storyboard.home) as? HomeView
            return home
        case .imageDetail:
            let storyboard = UIStoryboard(name: Storyboard.imageDetail, bundle: nil)
            let imageDetail = storyboard.instantiateViewController(withIdentifier: Storyboard.imageDetail) as? ImageDetailView
            return imageDetail
        case .history:
            let storyboard = UIStoryboard(name: Storyboard.history, bundle: nil)
            let history = storyboard.instantiateViewController(withIdentifier: Storyboard.history) as? HistoryView
            return history
        }
    }
}
