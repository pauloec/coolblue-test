//
//  ProductSearchCell.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import UIKit
import Core

class ProductCell: UITableViewCell, CellProtocol {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

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
        [nameLabel].forEach {
            contentView.addSubview($0)
        }

        nameLabel.anchorSuperview()
    }

    func bindViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        let output = viewModel.output

        output.name.bind(listener: { [weak self] name in
            self?.nameLabel.text = name
        })
    }
}
