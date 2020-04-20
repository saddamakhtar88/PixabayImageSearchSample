//
//  ImageSearchResultCollectionViewCell.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureWithData(data: ImageCollectionCellViewModel) {
        imageView.sd_setImage(with: URL(string: data.imageURL))
    }
}
