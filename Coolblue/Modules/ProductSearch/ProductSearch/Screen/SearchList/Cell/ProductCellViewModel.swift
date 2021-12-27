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
    }

    let input: Input
    let output: Output

    init() {
        input = Input()
        output = Output()
    }
}
