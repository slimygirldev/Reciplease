//
//  RecipeListTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit
import SwiftUI

class RecipeMiniatureCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "RecipeMiniatureCollectionViewCell"

// MARK: - Labels

    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        label.textColor = .black
        label.text = "Japanese Curry"
        label.lineBreakMode = .byTruncatingTail
        label.accessibilityLabel = "Recipe name \((label.text) ?? "Recipe name")"
        label.accessibilityHint = "This is the name of the recipe"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()

    let ingredientsListLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.accessibilityLabel = "Ingredients names"
        label.accessibilityHint = "This is the ingredient name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()

    let noteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8)
        label.textColor = .systemBlue
        label.text = "3.5"
        label.accessibilityHint = "Contains the Recipe note of \((label.text) ?? "3.5")"
        label.accessibilityLabel = "Note"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .cyan
        return label
    }()

    let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray2
        label.textAlignment = .right
        label.text = String(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()

// MARK: - Images

    let noteIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "star.fill")
        icon.tintColor = UIColor(red: 1, green: 0.733, blue: 0.2, alpha: 1)
        icon.accessibilityHint = "This is a star icon for illustrates note value"
        icon.accessibilityLabel = "Note icon"
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()

    let timerIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "timer")
        icon.tintColor = .systemGray
        icon.contentMode = .center
        icon.accessibilityHint = "This is a timer icon for illustrates cooking time value"
        icon.accessibilityLabel = "Timer icon"
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()

    let recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

//MARK: - StackViews

    let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        mainStackView.accessibilityLabel = "Recipe"
        mainStackView.accessibilityHint = "Contains the recipe, click here to go the recipe detail"
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.backgroundColor = .white
        return mainStackView
    }()

    let descriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.backgroundColor = .white
        stack.accessibilityHint = "Contains recipe nam, ingredient list preview, cooking time and cooking time incon"
        stack.accessibilityLabel = "Description container"
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let secondaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 0
        stack.accessibilityLabel = "Information container"
        stack.accessibilityHint = "Contains The informations relatives to Recipe like ngredients and cooking time"
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        return stack
    }()

    let noteHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.alignment = .center
        stack.accessibilityLabel = "Note labe and icon"
        stack.accessibilityHint = "Containss recipe's note and icon"
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .magenta
        return stack
    }()

// MARK: - Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        addViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: RecipeModel) {
        ingredientsListLabel.text = model.ingredients.joined(separator: ", ")
        recipeNameLabel.text = model.title
        self.recipeImage.image = model.image ?? UIImage(named: "pizza")
    }

    private func addViews() {
        addSubview(mainStackView)

        mainStackView.addArrangedSubview(recipeImage)

        mainStackView.addArrangedSubview(descriptionStackView)

        descriptionStackView.isLayoutMarginsRelativeArrangement = true
        descriptionStackView.layoutMargins = UIEdgeInsets(top: 10,
                                                          left: 10,
                                                          bottom: 10,
                                                          right: 10)

        descriptionStackView.addArrangedSubview(recipeNameLabel)
        descriptionStackView.addArrangedSubview(secondaryStackView)

        secondaryStackView.addArrangedSubview(ingredientsListLabel)
        secondaryStackView.addArrangedSubview(cookingTimeLabel)
        secondaryStackView.addArrangedSubview(timerIcon)


        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            timerIcon.widthAnchor.constraint(equalToConstant: 30),

        ])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 25, left: 15, bottom: 0, right: 5)
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
            RecipeMiniatureCollectionViewCell_Representable(model: RecipeModel(title: "Pizza Margarita",
                                                                               ingredients: ["Tomato","Mozzarella","Basilic"],
                                                                               image: nil))


            RecipeMiniatureCollectionViewCell_Representable(model: RecipeModel(title: "Pizza Margarita",
                                                                               ingredients: ["Tomato","Mozzarella","Basilic", "olives", "mustrad", "cheese"],
                                                                               image: nil))
            .previewDisplayName("Long name & ingredients list preview")
        }
        .frame(width: UIScreen.main.bounds.width,
               height: 250)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
