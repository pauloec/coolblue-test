//
//  ProductSearchCell.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import UIKit
import Core

class ProductCell: UITableViewCell, CellProtocol {
    typealias ViewModelProtocol = ProductCellViewModel
    private var viewModel: ViewModelProtocol?
    static var identifier: String = "productCell"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupViews()
    }


    func setupViews() {

    }

    func bindViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        let output = viewModel.output
    }
}
