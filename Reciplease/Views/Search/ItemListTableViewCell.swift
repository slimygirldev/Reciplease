//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 11/01/2023.
//

import UIKit
import MarqueeLabel

class ItemListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ItemListTableViewCell"

    private let itemLabel: MarqueeLabel = {
        let itemLabel = MarqueeLabel()
        itemLabel.font = .systemFont(ofSize: 18)
        itemLabel.accessibilityLabel = "Name of the ingredient"
        itemLabel.accessibilityHint = "This is an ingredient name, added with add button"
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        return itemLabel
    }()

    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 5
        mainStackView.accessibilityLabel = "Container of ingredient"
        mainStackView.accessibilityHint = "Contains the name and measurement if present of an ingredient for the recipe."
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        return mainStackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: String) {
        itemLabel.text = item
    }

    private func addViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(itemLabel)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
