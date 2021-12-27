//
//  PickupSearchViewController.swift
//  PickupSearch
//
//  Created by Paulo Correa on 12/12/2021.
//

import UIKit
import Core

class ProductSearchViewController: UIViewController, ViewControllerProtocol {
    private var tableView: UITableView! {
        didSet {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 120
            tableView.register(PickupSearchCell.self, forCellReuseIdentifier: PickupSearchCell.identifier)
            tableView.dataSource = self
        }
    }
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "location"), for: .normal)
        return button
    }()

    typealias ViewModelProtocol = PickupSearchViewModel
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

        viewModel.input
            .didLoad
            .onNext(())
    }

    func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        searchButton.addTarget(self, action: #selector(enableLocation), for: .touchUpInside)

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
        viewModel.output.title.bind(listener: { [weak self] title in
            self?.title = title
        })
        
        viewModel.output.items.bind(listener: { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        
        viewModel.output.error.bind(listener: { [weak self] error in
            let alert = UIAlertController(title: "Oops",
                                          message: error,
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: .cancel, handler: { (_) in }))
            self?.present(alert, animated: true, completion: nil)
        })
    }

    @objc private func enableLocation() {
        viewModel.input.didTapEnableLocation.onNext(())
    }
}

extension PickupSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.output.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PickupSearchCell.identifier, for: indexPath) as? PickupSearchCell else {
            return UITableViewCell()
        }

        let viewModel = viewModel.output.items.value[indexPath.row]
        cell.bindViewModel(viewModel: viewModel)
        return cell
    }
}
