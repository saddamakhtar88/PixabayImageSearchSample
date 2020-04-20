//
//  ImageSearchViewModel.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

class ImageSearchViewModel {
    
    enum Action {
        case Search
        case Pagination
    }
    
    private var searchImages: ImageSearchResultModel = ImageSearchResultModel()
    
    private let imageSearchDataService: ImageSearchDataService
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
    
    init(imageSearchDataService: ImageSearchDataService, pageSize: UInt = 20) {
        self.imageSearchDataService = imageSearchDataService
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
        
        imageSearchDataService.searchImage(searchKeyword: searchKeyword, pageNumber: pageNumber, pageSize: pageSize) { [weak self] (searchResult, error) in
            
            guard let weakSelf = self else { return }
            let actionType = pageNumber > 1 ? Action.Pagination : Action.Search
            
            if searchResult != nil && error == nil {
                if actionType == .Pagination {
                    weakSelf.searchImages.images = weakSelf.searchImages.images + searchResult!.images
                    weakSelf.currentPageNumber = pageNumber
                } else {
                    weakSelf.searchImages = searchResult!
                }
                weakSelf.onResultChange?(actionType, weakSelf.searchImages)
            } else {
                weakSelf.onError?(actionType, error)
            }
            
            weakSelf.isLoading = false
        }
    }
}
