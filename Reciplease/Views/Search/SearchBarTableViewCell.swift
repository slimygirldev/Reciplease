//
//  SearchBarTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 11/01/2023.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SearchBarTableViewCell"

    let text: UITextField = UITextField()

    let searchBarTextField: UITextField = {
        let searchBarTextField = UITextField()
        searchBarTextField.placeholder = "Enter an ingredient's name here ..."
        searchBarTextField.font = .systemFont(ofSize: 30)
        searchBarTextField.keyboardType = .default
        searchBarTextField.textAlignment = .left
        searchBarTextField.clearsOnInsertion = true
        searchBarTextField.clearButtonMode = .whileEditing
        searchBarTextField.becomeFirstResponder()
        return searchBarTextField
    }()

    let addButton: UIButton = {
        let addButton = UIButton()
        addButton.titleLabel?.text = "Add"
        return addButton
    }()

    let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
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

    private func addViews() {
        mainStackView.addSubview(searchBarTextField)
        mainStackView.addSubview(addButton)
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
