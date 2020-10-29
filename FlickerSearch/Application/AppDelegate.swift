//
//  AppDelegate.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //MARK: App Life Cycle Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Start the flow after application launch
       let coordinator = AppCoordinator(window: window ?? UIWindow())
        coordinator.start()
        return true
    }

}

