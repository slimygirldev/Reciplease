//
//  RecipeListTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit
import SwiftUI

class RecipeMiniatureCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let reuseIdentifier = "RecipeMiniatureCollectionViewCell"

// MARK: - Labels

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Japanese Curry"
        label.lineBreakMode = .byTruncatingTail
        label.accessibilityLabel = "Recipe name \((label.text) ?? "Recipe name")"
        label.accessibilityHint = "This is the name of the recipe"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var ingredientsListLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.lineBreakMode = .byTruncatingTail
        label.accessibilityLabel = "Ingredients names"
        label.accessibilityHint = "This is the ingredient name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()

// MARK: - Image

    private lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

//MARK: - Stacks

    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 0
        mainStackView.accessibilityLabel = "Recipe"
        mainStackView.accessibilityHint = "Contains the recipe, click here to go the recipe detail"
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.backgroundColor = .white
        return mainStackView
    }()

    private lazy var secondaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        stack.accessibilityLabel = "Information container"
        stack.accessibilityHint = "Contains The informations relatives to Recipe like ingredients and cooking time"
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
        return stack
    }()

    // MARK: - Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true

        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.825, green: 0.904, blue: 0.885, alpha: 1).cgColor

        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: RecipeModel) {
        ingredientsListLabel.text = model.ingredients.joined(separator: ", ")
        recipeNameLabel.text = model.title
        self.recipeImage.image = model.image ?? UIImage(named: "noImage")
    }

    // MARK: - Setup views & Constraints
    
    private func addViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(recipeImage)
        mainStackView.addArrangedSubview(secondaryStackView)
        secondaryStackView.addArrangedSubview(recipeNameLabel)
        secondaryStackView.addArrangedSubview(ingredientsListLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}

// MARK: - UI Preview (swiftUI)

struct RecipeMiniatureCollectionViewCell_Representable: UIViewRepresentable {
    let model: RecipeModel

    func makeUIView(context _: Context) -> RecipeMiniatureCollectionViewCell {
        let cell = RecipeMiniatureCollectionViewCell()
        cell.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        return cell
    }

    func updateUIView(_ uiView: RecipeMiniatureCollectionViewCell,
                      context _: Context) {
        uiView.configure(model: model)
    }
}

struct RecipeMiniatureCollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipeMiniatureCollectionViewCell_Representable(model: RecipeModel(url: "",
                                                                               title: "Pizza Margarita",
                                                                               ingredients: ["Tomato","Mozzarella","Basilic", "Tomato","Mozzarella","Basilic"],
                                                                               image: nil, ingredientLines: nil))


            RecipeMiniatureCollectionViewCell_Representable(model: RecipeModel(url: "",
                                                                               title: "Pizza Margarita",
                                                                               ingredients: ["Tomato","Mozzarella","Basilic", "olives", "mustrad", "cheese"],
                                                                               image: nil, ingredientLines: nil))
            .previewDisplayName("Long name & ingredients list preview")
        }
        .frame(width: UIScreen.main.bounds.width,
               height: 200)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
