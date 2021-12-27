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
    }
    struct Output {
        let error: PublishBinder<String>
    }

    let input: Input
    let output: Output

    private let errorBinder = PublishBinder<String>()

    init() {
        input = Input()
        output = Output(error: errorBinder)
    }
}
