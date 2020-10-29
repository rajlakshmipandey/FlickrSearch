//
//  AppCoordinator.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation
import UIKit


class AppCoordinator: Coordinator {
    
    //MARK: Properties
    let window: UIWindow
    
    
    //MARK: Initializer
    init(window: UIWindow) {
        self.window = window
        
    }
    
    //MARK: Custom methods
    func start() {
        showMainScreen()
        
        // Make the window key and visible.
        window.makeKeyAndVisible()
    }
    
    //Show Main Screen
    private func showMainScreen() {
        let coordinator = HomeCoordinator(window)
        coordinator.start()
    }
}
