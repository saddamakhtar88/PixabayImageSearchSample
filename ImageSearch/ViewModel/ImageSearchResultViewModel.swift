//
//  ImageSearchResultViewModel.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

class ImageSearchResultViewModel {
    var id: UInt
    var imageURL: String
    
    init(id: UInt, imageURL: String) {
        self.id = id
        self.imageURL = imageURL
    }
    
    init(image: ImageModel) {
        id = image.id
        imageURL = image.previewURL
    }
}
