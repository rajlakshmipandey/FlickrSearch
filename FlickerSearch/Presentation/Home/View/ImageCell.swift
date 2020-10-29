//
//  ImageCell.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    
    private var imageUrl: String?
    
    func configure(with data: String?){
        imageUrl = data
        setImage()
    }
}

// Method to  configure cell
extension ImageCell {
    
    private func setImage() {
        guard let imageString = imageUrl else {
            DispatchQueue.main.async {
                self.imageCell.image = ImageConstant.defaultImage
            }
            return
        }
        imageCell.loadImage(urlString: imageString)
    }
}
