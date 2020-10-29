//
//  ImageDetailCoordinator.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation
import UIKit

class ImageDetailCoordinator {
 
    //MARK: Properties
    var navigationController: UINavigationController?
    private var image: Image?
    
    
    //MARK: Initializer
    init(_ navController: UINavigationController?, imageData: Image) {
        navigationController = navController
        image = imageData
    }
    
    
    // Method to start the flow
    func start() {
        let viewModel = ImageDetailViewModel(image: image)
        guard let viewController = Views.imageDetail.view as? ImageDetailView else {return}
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
