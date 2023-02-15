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
        checkIsFavorites()
    }

    private func fetchCoreDataModel() -> RecipeDataModel? {
        let fetchRequest = RecipeDataModel.fetchRequest()

        // notation %@ veut dire que ca va etre la valeur de recipe.value.url
        fetchRequest.predicate = NSPredicate(format: "url=%@", recipe.value.url)
        do {
            let managedContext = CoreDataStack.shared.managedContext
            let results: [RecipeDataModel] = try managedContext.fetch(fetchRequest)
            return results.first
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return nil
        }

    }

    private func checkIsFavorites() {
        let coreDataModel: RecipeDataModel? = fetchCoreDataModel()
        if coreDataModel != nil {
            // Ici recipe avec la meme URL trouve
            isFavorite.value = true
        } else {
            isFavorite.value = false
        }
    }

    private func deleteFromFavorite() {
        let coreDataModel: RecipeDataModel? = fetchCoreDataModel()
        if let unwrappedCoreDataModel = coreDataModel {
            CoreDataStack.shared.managedContext.delete(unwrappedCoreDataModel)
            CoreDataStack.shared.saveContext()
            isFavorite.value = false
        }
    }

    private func addToFavorite() {
        let savedRecipe = RecipeDataModel(context: CoreDataStack.shared.viewContext)
        savedRecipe.url = recipe.value.url
        savedRecipe.image = recipe.value.image?.jpegData(compressionQuality: 1.0)
        savedRecipe.title = recipe.value.title
        savedRecipe.ingredients = recipe.value.ingredients
        savedRecipe.ingredientLines = recipe.value.ingredientLines
        CoreDataStack.shared.saveContext()
        isFavorite.value = true
    }

    func handleFavoriteState() {
//        isFavorite.value ? addToFavorite() : deleteFromFavorite()

        if isFavorite.value == false {
            addToFavorite()
        } else {
            deleteFromFavorite()
        }
    }
}
