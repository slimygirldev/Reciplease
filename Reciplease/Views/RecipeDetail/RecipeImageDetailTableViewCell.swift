//
//  RecipeImageDetailTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 27/01/2023.
//

import Foundation
import UIKit

class RecipeImageDetailTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    static let reuseIdentifier = "RecipeImageDetailTableViewCell"

    //MARK: - Image

    private lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.accessibilityHint = "This is the image of the recipe"
        image.accessibilityLabel = "Recipe photo"
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    //MARK: - Stacks

    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.backgroundColor = .red
        stack.distribution = .fill
        stack.accessibilityLabel = "Container of Recipe Image"
        stack.accessibilityHint = "Contains Recipe Image"
        stack.layer.cornerRadius = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: UIImage?) {
        self.recipeImage.image = image ?? UIImage(named: "noImage")
    }

    // MARK: - Setup views & Constraints

    private func addViews() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(recipeImage)
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
