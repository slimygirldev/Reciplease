//
//  RecipeListViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 28/01/2023.
//

import Foundation
import UIKit

final class RecipeListViewModel {
    private var error: Observable<String?> = Observable(nil)

    var recipeList: Observable<[RecipeModel]>

    var selectedRecipe: Observable<RecipeModel?> = Observable(nil)

    init(_ recipeList: [RecipeModel]) {
        self.recipeList = Observable(recipeList)
    }

}
