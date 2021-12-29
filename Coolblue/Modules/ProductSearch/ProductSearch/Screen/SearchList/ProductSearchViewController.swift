//
//  ProductSearchViewController.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import UIKit
import Core

class ProductSearchViewController: UIViewController, ViewControllerProtocol {
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.isTranslucent = true
        searchBar.placeholder = "I want..."
        return searchBar
    }()

    private var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .white
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 120
            tableView.dataSource = self
            tableView.delegate = self
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        }
    }

    private let loaderIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemBlue
        return activityIndicator
    }()


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

    override func viewDidAppear(_ animated: Bool) {
        searchBar.becomeFirstResponder()
        super.viewDidAppear(animated)
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        searchBar.delegate = self

        tableView = UITableView(frame: .zero, style: .plain)

        [tableView].forEach {
            view.addSubview($0)
        }

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
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

        output.showLoader.bind(listener: { [weak self] show in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if show {
                    self.view.addSubview(self.loaderIndicator)
                    self.loaderIndicator.center = self.view.center
                    self.loaderIndicator.startAnimating()
                } else {
                    self.loaderIndicator.stopAnimating()
                }
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

extension ProductSearchViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachingEnd = scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        if isReachingEnd {
            viewModel.input.onScrollToBottom.onNext(Swift.Void())
        }
    }
}

extension ProductSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.onTapSearch.onNext(searchBar.text)
        searchBar.resignFirstResponder()
    }
}
