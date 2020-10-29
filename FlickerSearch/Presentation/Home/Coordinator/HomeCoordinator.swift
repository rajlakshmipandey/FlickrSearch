//
//  HomeCoordinator.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit

class HomeCoordinator : Coordinator {
    
    // MARK: Properties
    private var window: UIWindow?
    var navigationController: UINavigationController?
    
    // MARK: Life Cycle
    init(_ window: UIWindow) {
        self.window = window
    }
    
    
    //MARK: Methods
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self, dependency: FlickerSearchDependency.getFlickerService())
        guard let viewController = Views.home.view as? HomeView else {return}
        viewController.viewModel = viewModel
        viewModel.searchResult = viewController
        
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = self.navigationController
    }
}

//Mark: HomeCoordinatorProtocol Methods
extension HomeCoordinator: HomeCoordinatorProtocol {
    
    //MARK: Update UI
    
    // Method to show the detailed image
    func showImage(_ imageName: Image) {
        let coordinator = ImageDetailCoordinator(navigationController, imageData: imageName)
        coordinator.start()
    }
    
    // Method to show the search history screen
    func showSearchHistory() {
        let coordinator = HistoryCoordinator(navigationController: self.navigationController ?? UINavigationController())
        coordinator.start()
    }
    
}
