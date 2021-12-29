//
//  ProductSearchEndpoint.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import Network
import Core

class ProductSearchEndpoint {
    /// Product Search request
    /// - Parameters:
    ///   - query: Input from user
    ///   - page: Number of page for lazy loading
    ///   - result: Result from request
    class func searchProduct(query: String,
                             page: Int,
                             result: PublishBinder<Swift.Result<ProductSearchResponse, ErrorModel>>) {
        ServiceManager.shared.sendRequest(request: ProductSearchRequest(), result: result)
    }
}

class ProductSearchRequest: RequestModel {
    override var path: String {
        return "/search"
    }
}

struct ProductSearchResponse: Codable {
    let products: [Product]
    let currentPage, pageSize, totalResults, pageCount: Int
}
