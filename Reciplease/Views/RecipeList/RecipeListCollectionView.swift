//
//  RecipeListCollectionView.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeListCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    private let horizontalPadding: Int = 16

    private let viewModel: RecipeListViewModel

    init(viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
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
        return viewModel.recipeList.value.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRecipe = viewModel.recipeList.value[indexPath.row]
        viewModel.selectedRecipe.value = selectedRecipe
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeMiniatureCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? RecipeMiniatureCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row < viewModel.recipeList.value.count {
            let model = viewModel.recipeList.value[indexPath.row]
            cell.configure(model: model)
        }
        return cell
    }
}

extension RecipeListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - CGFloat(horizontalPadding * 2), height: 190)
    }
}
