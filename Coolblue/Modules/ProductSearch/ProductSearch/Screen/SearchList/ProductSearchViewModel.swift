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
        let onScrollToBottom: PublishBinder<Void>
    }
    struct Output {
        let products: RelayBinder<[ProductCellViewModel]>
        let error: PublishBinder<String>
        let showLoader: RelayBinder<Bool>
    }

    let input: Input
    let output: Output

    private let onTapSearchBinder = PublishBinder<String>()
    private let onScrollToBottomBinder = PublishBinder<Void>()
    private let productsBinder = RelayBinder<[ProductCellViewModel]>.init([])
    private let errorBinder = PublishBinder<String>()
    private let showLoaderBinder = RelayBinder<Bool>.init(false)

    // Internal Control
    private let searchResult = PublishBinder<Result<ProductSearchResponse, ErrorModel>>()
    private var currentSearch = ""
    private var currentPage = 0
    private var pageCount = 0
    private var isLoading = false

    init() {
        input = Input(onTapSearch: onTapSearchBinder,
                      onScrollToBottom: onScrollToBottomBinder)
        output = Output(products: productsBinder,
                        error: errorBinder,
                        showLoader: showLoaderBinder)
        searchSetup()
    }

    private func searchSetup() {
        searchResult.bind(listener: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let viewModels = response.products.map {
                    ProductCellViewModel(product: $0)
                }
                self.productsBinder.value = self.productsBinder.value + viewModels
                self.currentPage = response.currentPage
                self.pageCount = response.pageCount
            case .failure(let error):
                self.errorBinder.onNext(error.localizedDescription)
            }

            self.setLoaderStatus(to: false)
        })

        onTapSearchBinder.bind(listener: { [weak self] text in
            self?.setLoaderStatus(to: true)
            self?.currentSearch = text
            self?.productsBinder.value = []
            self?.searchProduct(text: text, currentPage: 1)
        })

        onScrollToBottomBinder.bind(listener: { [weak self] in
            guard let self = self,
                  self.isLoading == false,
                  self.currentPage < self.pageCount else { return }
            self.searchProduct(text: self.currentSearch,
                               currentPage: self.currentPage + 1)
        })
    }

    private func setLoaderStatus(to loading: Bool) {
        isLoading = loading
        showLoaderBinder.value = loading
    }

    private func searchProduct(text: String, currentPage: Int) {
        setLoaderStatus(to: true)
        ProductSearchEndpoint.searchProduct(query: text,
                                            page: currentPage,
                                            result: searchResult)
    }
}
