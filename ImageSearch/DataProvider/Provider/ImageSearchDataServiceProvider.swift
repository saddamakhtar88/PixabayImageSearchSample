//
//  ImageSearchDataServiceProvider.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/20/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation
import Alamofire

class ImageSearchDataServiceProvider: ImageSearchDataService {
    
    // Move to Configuration class to handle multiple environments
    private let BaseUrl = "https://pixabay.com/api/"
    private let APIKey = "16120917-04ddc3c9cab1de757baaed6e4"
    
    func searchImage(searchKeyword: String, pageNumber: UInt, pageSize: UInt, completion: @escaping ((ImageSearchResultModel?, Error?) -> Void)) {
        let request = AF.request("\(BaseUrl)?key=\(APIKey)&q=\(searchKeyword)&per_page=\(pageSize)&page=\(pageNumber)")
        request.responseData { (response) in
            switch response.result {
            case .success:
                guard let result = response.value else {
                    completion(nil, nil)
                    return
                }
                
                guard let newPageImages = ImageSearchResultModel.instanceFromData(result) as? ImageSearchResultModel else {
                    completion(nil, nil)
                    return
                }
                completion(newPageImages, nil)
                
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
