//
//  ImageDetailView.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit

class ImageDetailView: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var image: UIImageView!
    var viewModel: ImageDetailViewModel?
    
    
    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Title.image
        loadImage()
    }
    
    
    //MARK: Custom methods
    
    // Method to Load images
    private func loadImage() {
        guard let imageURLString = viewModel?.getImageUrl() else {return}
        image.loadImage(urlString: imageURLString)
    }
    
}
