//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeDetailViewModel {

    private var favoriteRecipes: Observable<[RecipeModel]> = Observable([])

    private var isFavorite: Observable<Bool> = Observable(false)

    var recipe: Observable<RecipeModel>

    init(recipeModel: RecipeModel) {
        self.recipe = Observable(recipeModel)
    }

    func addToFavoriteList(_recipe: RecipeModel) {
        
    }
}
