//
//  ImageSearchViewModelTests.swift
//  ImageSearchTests
//
//  Created by Saddam Akhtar on 4/20/20.
//  Copyright © 2020 personal. All rights reserved.
//

import XCTest
@testable import ImageSearch

class ImageSearchViewModelTests: XCTestCase {

    var imageSearchDataServiceMock: ImageSearchDataServiceMock!
    var imageSearchViewModel: ImageSearchViewModel!
    
    override func setUp() {
        imageSearchDataServiceMock = ImageSearchDataServiceMock()
        imageSearchViewModel = ImageSearchViewModel(imageSearchDataService: imageSearchDataServiceMock)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchSuccess() {
        imageSearchDataServiceMock.error = nil
        imageSearchDataServiceMock.result = ImageSearchResultModel()
        imageSearchDataServiceMock.result!.totalHits = 100
        
        let expectation = XCTestExpectation(description: "returns expected search results")
        
        imageSearchViewModel.onResultChange = { [unowned self] (action, result) in
            XCTAssert(action == .Search)
            XCTAssert(result.totalHits == self.imageSearchDataServiceMock.result?.totalHits)
            expectation.fulfill()
        }
        
        imageSearchViewModel.searchText = "lorem"
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPaginationSuccess() {
        imageSearchDataServiceMock.error = nil
        imageSearchDataServiceMock.result = ImageSearchResultModel()
        imageSearchDataServiceMock.result!.totalHits = 100
        imageSearchDataServiceMock.result!.images = [ImageModel()]
        imageSearchViewModel.searchText = "lorem"
        
        let expectation = XCTestExpectation(description: "returns expected pagination results")
        
        imageSearchViewModel.onResultChange = { (action, result) in
            XCTAssert(action == .Pagination)
            XCTAssert(result.images.count == 2)
            expectation.fulfill()
        }
        
        imageSearchDataServiceMock.result!.images = [ImageModel()]
        imageSearchViewModel.loadNextSetOfImages()
        
        wait(for: [expectation], timeout: 2.0)
    }

    func testSearchFailure() {
        imageSearchDataServiceMock.error = nil
        imageSearchDataServiceMock.result = nil
        
        let expectation = XCTestExpectation(description: "calls onError closure")
        
        imageSearchViewModel.onError = { (action, error) in
            XCTAssert(action == .Search)
            expectation.fulfill()
        }
        
        imageSearchViewModel.searchText = "lorem"
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPaginationFailure() {
        imageSearchDataServiceMock.error = nil
        imageSearchDataServiceMock.result = ImageSearchResultModel()
        imageSearchDataServiceMock.result!.totalHits = 100
        imageSearchDataServiceMock.result!.images = [ImageModel()]
        imageSearchViewModel.searchText = "lorem"
        
        let expectation = XCTestExpectation(description: "calls onError closure")
        
        imageSearchViewModel.onError = { [unowned self] (action, error) in
            XCTAssert(action == .Pagination)
            XCTAssert(self.imageSearchViewModel.images.count == 1)
            expectation.fulfill()
        }
        
        imageSearchDataServiceMock.result = nil
        imageSearchViewModel.loadNextSetOfImages()
        
        wait(for: [expectation], timeout: 2.0)
    }

    func testSearchIgnoreGracefullyWhenNoSearchKeyword() {
        imageSearchDataServiceMock.error = nil
        imageSearchDataServiceMock.result = nil
        
        let expectation = XCTestExpectation(description: "should not be fullfilled")
        expectation.isInverted = true
        
        imageSearchViewModel.onResultChange = { (action, result) in
            expectation.fulfill()
        }
        
        imageSearchViewModel.onError = { (action, error) in
            expectation.fulfill()
        }
        
        imageSearchViewModel.searchText = ""
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPaginationIgnoreGracefullyWhenNoMorePage() {
        imageSearchDataServiceMock.error = nil
        imageSearchDataServiceMock.result = ImageSearchResultModel()
        imageSearchDataServiceMock.result!.totalHits = 1
        imageSearchDataServiceMock.result!.images = [ImageModel()]
        imageSearchViewModel.searchText = "lorem"
        
        let expectation = XCTestExpectation(description: "should not be fullfilled")
        expectation.isInverted = true
        
        imageSearchViewModel.onResultChange = { (action, result) in
            expectation.fulfill()
        }
        
        imageSearchViewModel.onError = { (action, error) in
            expectation.fulfill()
        }
        
        XCTAssert(imageSearchViewModel.areMoreImagesAvailable == false)
        
        imageSearchDataServiceMock.result!.images = [ImageModel()]
        imageSearchViewModel.loadNextSetOfImages()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
}
