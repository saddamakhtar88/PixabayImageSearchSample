//
//  ImageModel.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

class ImageModel: BaseModel {
    
    static func instanceFromDictionary(_ dictionary: [String : Any]?) -> Any? {
        if dictionary == nil {
            return nil
        }
        
        let instance = ImageModel()
        instance.setAttributesFromDictionary(dictionary)
        
        return instance
    }
    
    func setAttributesFromDictionary(_ dictionary: [String : Any]?) {
        id = dictionary?["id"] as? UInt
        previewURL = dictionary?["previewURL"] as? String
        largeImageURL = dictionary?["largeImageURL"] as? String
        likes = dictionary?["likes"] as? UInt ?? 0
        comments = dictionary?["comments"] as? UInt ?? 0
        prTags = dictionary?["tags"] as? String
        previewImageWidth = dictionary?["previewWidth"] as? UInt ?? 0
        previewImageHeight = dictionary?["previewHeight"] as? UInt ?? 0
    }
    
    private var prTags: String!
    
    var id: UInt!
    var previewURL: String!
    var largeImageURL: String!
    var likes: UInt = 0
    var comments: UInt = 0
    var previewImageWidth: UInt = 0
    var previewImageHeight: UInt = 0
    
    var tags: [String] {
        prTags.components(separatedBy: ",").map {$0.trimmingCharacters(in: CharacterSet.whitespaces)}
    }

    var previewImageHeightWidthRatio: Float {
        Float(previewImageHeight) / Float(previewImageWidth)
    }
}
