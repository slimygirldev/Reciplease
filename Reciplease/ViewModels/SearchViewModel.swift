//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import UIKit

final class SearchViewModel {

    // MARK: - Properties

    var error: Observable<String?> = Observable(nil)

    var ingredientsList: Observable<[String]> = Observable([])

    var recipes: Observable<[RecipeModel]> = Observable([])

    var isSearching: Observable<Bool> = Observable(false)

    let networkService: NetworkProcotol

    // MARK: - Methods
    
    init(networkService: NetworkProcotol) {
        self.networkService = networkService
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addIngredient(_ ingredient: String) {
        let newEntry = ingredient.split(separator: ",")
        ingredientsList.value.append(contentsOf: newEntry.map({String($0)}))
    }

    func clearItemList() {
        ingredientsList.value = []
    }

    func request() {
        isSearching.value = true
        if !ingredientsList.value.isEmpty {
            self.recipes.value = []
            networkService.fetchData(entries: ingredientsList.value) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.error.value = error.localizedDescription
                    self?.isSearching.value = false
                    // handle error
                case .success(let receivedRecipes):
                    self?.recipes.value = receivedRecipes
                    self?.isSearching.value = false
                }
            }
        }
    }
}
