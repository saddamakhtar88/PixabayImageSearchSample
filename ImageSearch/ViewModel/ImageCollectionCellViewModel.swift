//
//  ImageSearchResultViewModel.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

class ImageCollectionCellViewModel {
    var id: UInt
    var imageURL: String
    var tags: String
    
    init(image: ImageModel) {
        id = image.id
        imageURL = image.previewURL
        
        let maxtags: Int = 3
        let tagsCount = image.tags.count < maxtags ? image.tags.count : maxtags
        tags = image.tags[..<tagsCount].reduce("", { $0 == "" ? $1 : "\($0), \($1)" })
    }
    
    static func heightFor(image: ImageModel, width: Float) -> Float {
        width * image.previewImageHeightWidthRatio
    }
 }
