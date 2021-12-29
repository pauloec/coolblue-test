//
//  ProductSearchCell.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import UIKit
import Core
import ImageDownloader

class ProductCell: UITableViewCell, CellProtocol {
    private let imageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return imageView
    }()

    private let producStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()

    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let USPsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    private let buyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 6
        return button
    }()

    typealias ViewModelProtocol = ProductCellViewModel
    private var viewModel: ViewModelProtocol?
    static var identifier: String = "productCell"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white
        selectionStyle = .none
        setupViews()
    }

    func setupViews() {
        [imageImageView, producStack].forEach {
            contentView.addSubview($0)
        }

        imageImageView.anchor(top: producStack.topAnchor,
                              leading: contentView.leadingAnchor,
                              size: .init(width: LayoutContraint.ImageView.width,
                                          height: LayoutContraint.ImageView.height),
                              topPriority: .required,
                              leadingPriority: .required,
                              widthPriority: .init(LayoutContraint.ImageView.widthPriority),
                              heightPriority: .init(LayoutContraint.ImageView.heightPriority))

        producStack.anchor(top: contentView.topAnchor,
                         leading: imageImageView.trailingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: .init(top: LayoutContraint.ProductStack.Padding.top,
                                        left: LayoutContraint.ProductStack.Padding.left,
                                        bottom: LayoutContraint.ProductStack.Padding.bottom,
                                        right: LayoutContraint.ProductStack.Padding.right),
                         leadingPriority: .required,
                         trailingPriority: .required)

        [nameLabel, reviewLabel, USPsLabel, priceLabel, buyButton].forEach {
            producStack.addArrangedSubview($0)
        }
    }

    func bindViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        let output = viewModel.output

        output.imageUrl
            .bind(listener: { [weak self] url in
                guard let self = self else { return }

                ImageDownloader.shared.loadImage(from: url)
                    .bind(listener: { image in
                        DispatchQueue.main.async {
                            self.imageImageView.image = image
                        }
                    })
            })

        output.name
            .bind(listener: { [weak self] text in
                self?.nameLabel.text = text
            })

        output.review
            .bind(listener: { [weak self] text in
                self?.reviewLabel.text = text
            })

        output.USPs
            .bind(listener: { [weak self] text in
                self?.USPsLabel.text = text
            })

        output.price
            .bind(listener: { [weak self] text in
                self?.priceLabel.text = text
            })
    }
}

extension ProductCell {
    struct LayoutContraint {
        struct ImageView {
            static let height: CGFloat = 150
            static let width: CGFloat = 150
            static let widthPriority: Float = 800
            static let heightPriority: Float = 800
        }
        struct ProductStack {
            struct Padding {
                static let top: CGFloat = 20
                static let left: CGFloat = 20
                static let bottom: CGFloat = 20
                static let right: CGFloat = 20
            }
        }
    }
}

