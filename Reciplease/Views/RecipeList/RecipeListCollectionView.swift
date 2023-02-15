//
//  RecipeListCollectionView.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeListCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Properties

    private let horizontalPadding: Int = 16

    var recipes: [RecipeModel] = []

    var onSelected: ((_ recipe: RecipeModel) -> Void)?

    // MARK: - Methods

    init(recipes: [RecipeModel]) {
        self.recipes = recipes
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        backgroundColor = .systemBackground

        delegate = self
        dataSource = self

        self.register(RecipeMiniatureCollectionViewCell.self,
                      forCellWithReuseIdentifier: RecipeMiniatureCollectionViewCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        onSelected?(selectedRecipe)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeMiniatureCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? RecipeMiniatureCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row < recipes.count {
            let model = recipes[indexPath.row]
            cell.configure(model: model)
        }
        return cell
    }
}

// MARK: - Extensions

extension RecipeListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - CGFloat(horizontalPadding * 2), height: 190)
    }
}
