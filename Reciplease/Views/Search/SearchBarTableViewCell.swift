//
//  SearchBarTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 11/01/2023.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SearchBarTableViewCell"

    var addIngredient: ((String) -> Void)?

    let searchBarTextField: UITextField = {
        let searchBarTextField = UITextField()
        searchBarTextField.placeholder = "Enter an ingredient's name here ..."
        searchBarTextField.font = .systemFont(ofSize: 16)
        searchBarTextField.keyboardType = .default
        searchBarTextField.textAlignment = .left
        searchBarTextField.clearsOnInsertion = true
        searchBarTextField.clearButtonMode = .whileEditing
        searchBarTextField.becomeFirstResponder()
        searchBarTextField.accessibilityLabel = "Text field add ingredient"
        searchBarTextField.accessibilityHint = "Here you can enter an ingredient presents in your fridge"
        searchBarTextField.translatesAutoresizingMaskIntoConstraints = false
        return searchBarTextField
    }()

    let addButton: UIButton = {
        let addButton = UIButton(type: .custom)
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = UIColor(red: 0.161, green: 0.8, blue: 0.373, alpha: 1)
        addButton.addTarget(self, action: #selector(addButtonTapped),
                            for: .touchUpInside)
        addButton.accessibilityLabel = "Add Button"
        addButton.accessibilityHint = "This button add the ingredient entered in the text field in the list of ingredients in your fridge"
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()

    let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.spacing = 5
        mainStackView.accessibilityLabel = "Container Add text field and button"
        mainStackView.accessibilityHint = "This element contains the add ingredent text field and the add button"
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
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

    @objc func addButtonTapped() {
        guard let ingredient = searchBarTextField.text else { return }

        guard ingredient.isEmpty == false else {
            return
        }

        addIngredient?(ingredient)
        searchBarTextField.text = ""
    }

    private func addViews() {
        mainStackView.addArrangedSubview(searchBarTextField)
        mainStackView.addArrangedSubview(addButton)
        contentView.addSubview(mainStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 70),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
