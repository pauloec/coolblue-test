//
//  ProductSearchCoordinator.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import Core

public class ProductSearchCoordinator: CoordinatorProtocol {
    public var navigationController: UINavigationController
    private var productSearchViewModel: ProductSearchViewModel?
    
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewModel = ProductSearchViewModel()
        self.productSearchViewModel = viewModel
        
        let viewController = ProductSearchViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
