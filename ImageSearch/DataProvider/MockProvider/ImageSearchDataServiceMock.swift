//
//  ImageSearchDataServiceMock.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/20/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

class ImageSearchDataServiceMock: ImageSearchDataService {
    
    var result: ImageSearchResultModel?
    var error: Error?
    
    func searchImage(searchKeyword: String, pageNumber: UInt, pageSize: UInt, completion: @escaping ((ImageSearchResultModel?, Error?) -> Void)) {
        completion(result, error)
    }
}
