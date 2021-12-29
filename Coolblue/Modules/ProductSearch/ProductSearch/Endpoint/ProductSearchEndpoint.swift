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
        ServiceManager.shared.sendRequest(request: ProductSearchRequest(query: query, page: page),
                                          result: result)
    }
}

class ProductSearchRequest: RequestModel {
    private var query: String
    private var page: String

    override var path: String {
        return "/search"
    }

    override var parameters: [String : Any?] {
        return [
            "query": query,
            "page": page
        ]
    }

    init(query: String, page: Int) {
        self.query = query
        self.page = String(page)
    }
}

struct ProductSearchResponse: Codable {
    let products: [Product]
    let currentPage, pageSize, totalResults, pageCount: Int
}
