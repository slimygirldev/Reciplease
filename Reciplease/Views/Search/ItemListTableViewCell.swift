//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 11/01/2023.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ItemListTableViewCell"

    let itemSlot: UILabel = {
        let itemList = UILabel()
        itemList.font = .systemFont(ofSize: 18)
        itemList.translatesAutoresizingMaskIntoConstraints = false
        return itemList
    }()

    let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        return mainStackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: String) {
        itemSlot.text = item
    }

    private func addViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(itemSlot)

        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}
