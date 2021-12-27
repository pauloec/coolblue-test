//
//  ViewControllerProtocol.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

public protocol ViewControllerProtocol {
    associatedtype ViewModelProtocol

    /// Designated Initializer
    init(viewModel: ViewModelProtocol)

    /// Initial view setup
    func setupViews()

    /// Required method to be called to bind data status with view
    func bindViewModel()
}
