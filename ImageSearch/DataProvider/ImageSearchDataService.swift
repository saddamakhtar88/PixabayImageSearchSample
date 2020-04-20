//
//  ImageSearchService.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/20/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

protocol ImageSearchDataService {
    func searchImage(searchKeyword: String, pageNumber: UInt, pageSize: UInt, completion: @escaping ((ImageSearchResultModel?, Error?) -> Void))
}
