//
//  ProductSearchEndpoint.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2564 BE.
//

import Network
import Core

class ProductSearchEndpoint {
    class func searchProduct(result: PublishBinder<Swift.Result<ProductSearchResponse, ErrorModel>>) {
        ServiceManager.shared.sendRequest(request: ProductSearchRequest(), result: result)
    }
}

class ProductSearchRequest: RequestModel {
    override var path: String {
        return "/search"
    }
}

struct ProductSearchResponse: Codable {
    
}
