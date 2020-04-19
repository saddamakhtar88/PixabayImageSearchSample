//
//  ImageDetailViewController.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentsLikesLabel: UILabel!
    
    var image: ImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let image = self.image else {
            return
        }
        
        imageView.sd_setImage(with: URL(string: image.largeImageURL))
        commentsLikesLabel.text = "Likes: \(image.likes)   Comments: \(image.comments)"
    }
}
