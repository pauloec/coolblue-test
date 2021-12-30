//
//  ProductSearchCellViewModel.swift
//  ProductSearch
//
//  Created by Paulo Correa on 12/12/2021.
//

import Core

class ProductCellViewModel: ViewModelProtocol {
    /// No input required for this cell
    struct Input { }
    struct Output {
        let name: RelayBinder<String>
        let review: RelayBinder<String>
        let imageUrl: RelayBinder<URL>
        let USPs: RelayBinder<String>
        let price: RelayBinder<String>
    }

    let input: Input
    let output: Output

    init(product: Product) {
        let nameBinder: RelayBinder<String> = .init(product.name)
        let reviewBinder: RelayBinder<String> = .init("★ \(product.reviewInformation.summary.average) / \(product.reviewInformation.summary.count) Reviews")
        let imageUrlBinder: RelayBinder<URL> = .init(product.imageUrl)
        let uspsBinder: RelayBinder<String> = .init("• " + product.USPs.joined(separator: "\n• "))
        let priceBinder: RelayBinder<String> = .init(String(format: "%.2f", product.salesPriceIncVat))

        input = Input()
        output = Output(name: nameBinder,
                        review: reviewBinder,
                        imageUrl: imageUrlBinder,
                        USPs: uspsBinder,
                        price: priceBinder)
    }
}
