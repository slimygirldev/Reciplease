//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeDetailViewModel {

    var favoriteRecipes: Observable<[RecipeModel]> = Observable([])

    var isFavorite: Observable<Bool> = Observable(false)

    var recipe: Observable<RecipeModel>

    init(recipeModel: RecipeModel) {
        self.recipe = Observable(recipeModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addToFavoriteList(_recipe: RecipeModel) {
        
    }
}
