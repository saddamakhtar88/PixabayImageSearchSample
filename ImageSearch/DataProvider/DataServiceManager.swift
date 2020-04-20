//
//  DataServiceManager.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/20/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

class DataServiceManager {
    
    static let shared = DataServiceManager(imageSearchDataService: prImageSearchDataService!)
    
    static var prImageSearchDataService: ImageSearchDataService?
    
    let imageSearchDataService: ImageSearchDataService
    
    private init(imageSearchDataService: ImageSearchDataService) {
        self.imageSearchDataService = imageSearchDataService
    }
    
    static func setup(imageSearchDataService: ImageSearchDataService) {
        prImageSearchDataService = imageSearchDataService
    }
}
