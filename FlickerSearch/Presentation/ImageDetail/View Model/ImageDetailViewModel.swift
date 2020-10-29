//
//  ImageDetailViewModel.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation


class ImageDetailViewModel : ImageDetailProtocol {
    
    // MARK: properties
    private  var image: Image?
    
    
    // MARK: Life Cycle
    init(image: Image?) {
        self.image = image
    }
    
    
    //MARK: Methods
    
    // Method to get url of images
    func getImageUrl() -> String? {
        guard let image = image else {return nil}
        let flickerImage = FlickerSearchAPI.flickerImage(photo: image, size: ImageSize.large)
        return flickerImage.baseURL.absoluteString + flickerImage.path
    }
    
}
