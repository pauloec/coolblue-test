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
        viewModel.output.error.bind(listener: { [weak self] error in
            let alert = UIAlertController(title: "Oops",
                                          message: error,
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: .cancel, handler: { (_) in }))
            self?.present(alert, animated: true, completion: nil)
        })
    }
}

extension ProductSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
