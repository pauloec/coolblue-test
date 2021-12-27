//
//  ProductSearchViewModel.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import Foundation
import Core
import Network

class ProductSearchViewModel: ViewModelProtocol {
    struct Input {
        let onTapSearch: PublishBinder<String>
        let onScrollToBottom: PublishBinder<Bool>
    }
    struct Output {
        let products: RelayBinder<[ProductCellViewModel]>
        let error: PublishBinder<String>
    }

    let input: Input
    let output: Output

    private let onTapSearchBinder = PublishBinder<String>()
    private let onScrollToBottomBinder = PublishBinder<Bool>()
    private let productsBinder = RelayBinder<[ProductCellViewModel]>.init([])
    private let errorBinder = PublishBinder<String>()

    init() {
        input = Input(onTapSearch: onTapSearchBinder,
                      onScrollToBottom: onScrollToBottomBinder)
        output = Output(products: productsBinder,
                        error: errorBinder)

        searchSetup()

        onTapSearchBinder.onNext("text")
    }

    private func searchSetup() {
        let searchResult = PublishBinder<Result<ProductSearchResponse, ErrorModel>>()
        searchResult.bind(listener: { [weak self] result in
            switch result {
            case .success(let response):
                let viewModels = response.products.map {
                    ProductCellViewModel(product: $0)
                }
                self?.productsBinder.value = viewModels
            case .failure(let error):
                self?.errorBinder.onNext(error.localizedDescription)
            }
        })

        onTapSearchBinder.bind(listener: { text in
            ProductSearchEndpoint.searchProduct(query: text,
                                                page: 1,
                                                result: searchResult)
        })
    }
}
