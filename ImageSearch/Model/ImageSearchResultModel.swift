//
//  ImageSearchResultModel.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

class ImageSearchResultModel: BaseModel {
    var total: UInt = 0
    var totalHits: UInt = 0
    var images: [ImageModel] = []
    
    static func instanceFromDictionary(_ dictionary: [String : Any]?) -> Any? {
        if dictionary == nil {
            return nil
        }
        
        let instance = ImageSearchResultModel()
        instance.setAttributesFromDictionary(dictionary)
        
        return instance
    }
    
    func setAttributesFromDictionary(_ dictionary: [String : Any]?) {
        total = dictionary?["total"] as? UInt ?? 0
        totalHits = dictionary?["totalHits"] as? UInt ?? 0
        images = listFromRawArray(dictionary?["hits"] as? [Any]) ?? []
    }
    
}
