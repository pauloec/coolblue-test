//
//  ProductSearchCellViewModel.swift
//  ProductSearch
//
//  Created by Paulo Correa on 12/12/2021.
//

import Core

class ProductCellViewModel: ViewModelProtocol {
    struct Input {

    }
    struct Output {
        let name: RelayBinder<String>
    }

    let input: Input
    let output: Output

    init(product: Product) {
        let nameBinder: RelayBinder<String> = .init(product.name)

        input = Input()
        output = Output(name: nameBinder)
    }
}
