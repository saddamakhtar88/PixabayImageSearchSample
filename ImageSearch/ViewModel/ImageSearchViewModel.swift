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
    
    private var searchImages: ImageSearchResultModel = ImageSearchResultModel()
    
    private var isLoading: Bool = false
    private var pageSize: UInt
    private var currentPageNumber: UInt = 1
    
    var searchText: String = "" {
        didSet {
            guard searchText.isEmpty == false else {
                return
            }
            searchImages(searchKeyword: searchText, pageNumber: 1)
        }
    }
    
    var onResultChange: ((Action, ImageSearchResultModel) -> Void)?
    var onError: ((Action, Error?) -> Void)?
    
    var images: [ImageModel] {
        searchImages.images
    }
    
    var areMoreImagesAvailable: Bool {
        return searchImages.totalHits > images.count
    }
    
    init(pageSize: UInt = 20) {
        self.pageSize = pageSize
    }
    
    func loadNextSetOfImages() {
        guard !isLoading && areMoreImagesAvailable else {
            return
        }
        
        searchImages(searchKeyword: searchText, pageNumber: currentPageNumber + 1)
    }
    
    private func searchImages(searchKeyword: String, pageNumber: UInt) {
        isLoading = true
        let request = AF.request("https://pixabay.com/api/?key=16120917-04ddc3c9cab1de757baaed6e4&q=\(searchKeyword)&per_page=\(pageSize)&page=\(pageNumber)")
        request.responseData { [weak self] (response) in

            guard let weakSelf = self else { return }
            let actionType = pageNumber > 1 ? Action.Pagination : Action.Search
            switch response.result {
            case .success:
                guard let result = response.value else {
                    weakSelf.onError?(actionType, nil)
                    return
                }
                if actionType == .Pagination {
                    guard let newPageImages = ImageSearchResultModel.instanceFromData(result) as? ImageSearchResultModel else {
                        weakSelf.onError?(actionType, nil)
                        return
                    }
                    weakSelf.searchImages.images = weakSelf.searchImages.images + newPageImages.images
                    weakSelf.currentPageNumber = pageNumber
                } else {
                    weakSelf.searchImages = ImageSearchResultModel.instanceFromData(result) as? ImageSearchResultModel ?? weakSelf.searchImages
                }
                weakSelf.onResultChange?(actionType, weakSelf.searchImages)
            case let .failure(error):
                weakSelf.onError?(pageNumber > 1 ? Action.Pagination : Action.Search, error)
            }
            
            weakSelf.isLoading = false
        }
    }
}
