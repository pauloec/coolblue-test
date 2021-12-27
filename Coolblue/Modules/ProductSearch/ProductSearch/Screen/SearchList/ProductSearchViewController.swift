//
//  ProductSearchViewController.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import UIKit
import Core

class ProductSearchViewController: UIViewController, ViewControllerProtocol {
    private var tableView: UITableView! {
        didSet {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 120
            tableView.dataSource = self
            tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        }
    }

    typealias ViewModelProtocol = ProductSearchViewModel
    private var viewModel: ViewModelProtocol

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViewModel()
    }

    func setupViews() {
        tableView = UITableView(frame: .zero, style: .plain)

        [tableView].forEach {
            view.addSubview($0)
        }

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
    }

    func bindViewModel() {
        let output = viewModel.output
        output.error.bind(listener: { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Oops",
                                              message: error,
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: { (_) in }))
                self?.present(alert, animated: true, completion: nil)
            }
        })

        output.products.bind(listener: { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}

extension ProductSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.output.products.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }

        let viewModel = viewModel.output.products.value[indexPath.row]
        cell.bindViewModel(viewModel: viewModel)
        return cell
    }
}
