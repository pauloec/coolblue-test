//
//  CellProtocol.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

public protocol CellProtocol {
    associatedtype ViewModelProtocol

    /// Cell Identifier to be used with UITableView Delegate
    static var identifier:  String { get }

    /// Initial view setup
    func setupViews()

    /// Required method to be called, useful to be called on cellForRow:indexPath
    func bindViewModel(viewModel: ViewModelProtocol)
}
