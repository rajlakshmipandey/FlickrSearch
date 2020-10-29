//
//  HistoryCoordinator.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation
import UIKit

class HistoryCoordinator: Coordinator {
    
    //MARK: Properties
    var navigationController: UINavigationController?
    
    //MARK: Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }    
    
    // Method to build the view - view model relation
    func start() {
        let viewModel = HistoryViewModel()
        guard let viewController = Views.history.view as? HistoryView else {return}
        viewController.viewModel = viewModel
        viewModel.historyResult = viewController
        
        navigationController?.pushViewController(viewController, animated: false)
    }
}
