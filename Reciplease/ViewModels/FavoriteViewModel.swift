//
//  FavoriteViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 30/01/2023.
//

import Foundation
import UIKit

final class FavoriteViewModel {
    // connexion avec core data
    var favoritesRecipes: Observable<[RecipeModel]> = Observable([])
    
    var isFavorite: Observable<Bool> = Observable(false)

    var recipe: Observable<RecipeModel>


    init() {
        // charger receette depuis core data
        // favoritesRecipes.value = recipesFromCoredata
        // collectionV.reloadData()
    }
}

extension FavoriteViewModel {
    // recipes core data set up
}
