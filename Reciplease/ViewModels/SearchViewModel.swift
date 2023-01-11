//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

class SearchViewModel {

   // var tableView: SearchTableView

    private let networkService: NetworkService

    var ingredientsList: [String] = ["tomato"]

    var recipes: [RecipeModel] = []

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func request() {
        if ingredientsList.isEmpty == false {
            networkService.fetchData(entries: ingredientsList) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .failure(let error):
                    print("error is : \(error.localizedDescription)")
                case .success(let receivedRecipes):
                    self.recipes = receivedRecipes
                }
            }
        } else {
            // here vm must notify that something went wrong
        
        }
    }
}
