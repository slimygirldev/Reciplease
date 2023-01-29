//
//  ClearButtonTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 18/01/2023.
//


import UIKit

class ClearButtonTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ClearButtonTableViewCell"

    var clearIngredientsList: (() -> Void)?

    private lazy var clearButton: UIButton = {
        let clearButton = UIButton(type: .custom)
        clearButton.setTitle("Clear List", for: .normal)
        clearButton.backgroundColor = UIColor(red: 1, green: 0.302, blue: 0.302, alpha: 1)
        clearButton.addTarget(self, action: #selector(clearItems),
                            for: .touchUpInside)
        clearButton.accessibilityHint = "Tap this button to clear the list of ingredients below"
        clearButton.accessibilityLabel = "Button Clear List"
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        return clearButton
    }()

    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.spacing = 5
        mainStackView.accessibilityLabel = "Container Clear Button"
        mainStackView.accessibilityHint = "Contains the clear button"
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

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10,
                                                                     bottom: 10, right: 10))
    }

    @objc func clearItems() {
        clearIngredientsList?()
    }

    private func addViews() {
        mainStackView.addArrangedSubview(clearButton)
        contentView.addSubview(mainStackView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
