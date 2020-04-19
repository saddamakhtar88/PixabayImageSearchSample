//
//  ImageSearchViewModel.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation
import Alamofire

class ImageSearchViewModel {
    
    enum Action {
        case Search
        case Pagination
    }
    
    private static let DefaultPageSize: Int = 20;
    private var searchImages: ImageSearchResultModel = ImageSearchResultModel() {
        didSet {
            onResultChange?(searchImages)
        }
    }
    
    var searchText: String = "" {
        didSet {
            guard searchText.isEmpty == false else {
                return
            }
            searchImages(searchKeyword: searchText)
        }
    }
    var onResultChange: ((ImageSearchResultModel) -> Void)?
    var onError: ((Action, Error) -> Void)?
    
    var images: [ImageModel] {
        searchImages.images
    }
    
    var areMoreImagesAvailable: Bool {
        return true
    }
    
    func loadNextSetOfImages(numberOfImages: Int = DefaultPageSize) {
        // onError
    }
    
    private func searchImages(searchKeyword: String) {
        let request = AF.request("https://pixabay.com/api/?key=16120917-04ddc3c9cab1de757baaed6e4&q=\(searchKeyword)")
        request.responseData { [weak self] (response) in
            guard let result = response.value, let weakSelf = self else { return }
            weakSelf.searchImages = ImageSearchResultModel.instanceFromData(result) as? ImageSearchResultModel ?? weakSelf.searchImages
        }
        // onError
    }
}
