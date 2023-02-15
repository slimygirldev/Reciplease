//
//  FavoriteViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 30/01/2023.
//

import Foundation
import UIKit
import CoreData

final class FavoriteViewModel {
    var recipeList: Observable<[RecipeModel]>

    init() {
        self.recipeList = Observable([])
        loadFavorites()
    }

    private func makeRecipe(_ requestResults: [RecipeDataModel]) -> [RecipeModel] {
        var finalResult: [RecipeModel] = []
        for result in requestResults {
            let recipeModel: RecipeModel = RecipeModel(url: result.url ?? "",
                                                       title: result.title ?? "",
                                                       ingredients: result.ingredients ?? [],
                                                       image: UIImage(data: result.image ?? Data()),
                                                       ingredientLines: result.ingredientLines ?? [])
            finalResult.append(recipeModel)
        }
        return finalResult
    }

    func loadFavorites() {
        let fetchRequest = RecipeDataModel.fetchRequest()
        do {
            let managedContext = CoreDataStack.shared.managedContext
            let results: [RecipeDataModel] = try managedContext.fetch(fetchRequest)

            let recipeModels = makeRecipe(results)
            self.recipeList.value = recipeModels

        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}
