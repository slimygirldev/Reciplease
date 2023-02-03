//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

final class RecipeDetailViewModel {

    // MARK: - Properties

    var isFavorite: Observable<Bool> = Observable(false)

    var recipe: Observable<RecipeModel>

    // MARK: - Methods
    
    init(recipeModel: RecipeModel) {
        self.recipe = Observable(recipeModel)
    }

    func addToFavoriteList() {
        //verifier if isFavorite
    }
}
