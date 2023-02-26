//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit
import CoreData

final class RecipeDetailViewModel {

    // MARK: - Properties

    var isFavorite: Observable<Bool> = Observable(false)

    var recipe: Observable<RecipeModel>
    private var coreDataStack: CoreDataStack

    // MARK: - Methods
    
    init(recipeModel: RecipeModel, _ isTesting: Bool = false) {
        coreDataStack = CoreDataStack.shared
        coreDataStack.isTesting = isTesting
        self.recipe = Observable(recipeModel)
        checkIsFavorites()
    }

    private func fetchCoreDataModel() -> RecipeDataModel? {
        let fetchRequest = RecipeDataModel.fetchRequest()

        // notation %@ veut dire que ca va etre la valeur de recipe.value.url
        fetchRequest.predicate = NSPredicate(format: "url=%@", recipe.value.url)
        do {
            let managedContext = coreDataStack.managedContext
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
            coreDataStack.managedContext.delete(unwrappedCoreDataModel)
            coreDataStack.saveContext()
            isFavorite.value = false
        }
    }

    private func addToFavorite() {
        let savedRecipe = RecipeDataModel(context: coreDataStack.viewContext)
        savedRecipe.url = recipe.value.url
        savedRecipe.image = recipe.value.image?.jpegData(compressionQuality: 1.0)
        savedRecipe.title = recipe.value.title
        savedRecipe.ingredients = recipe.value.ingredients
        savedRecipe.ingredientLines = recipe.value.ingredientLines
        coreDataStack.saveContext()
        isFavorite.value = true
    }

    @discardableResult func handleFavoriteState() -> Bool {
        if isFavorite.value == false {
            addToFavorite()
            return true
        } else {
            deleteFromFavorite()
            return false
        }
    }
}
