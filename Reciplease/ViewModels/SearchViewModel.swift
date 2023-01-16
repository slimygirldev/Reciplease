//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import UIKit

class SearchViewModel {

    var error: Observable<String?> = Observable(nil)

    var tableView = SearchTableView(frame: .zero, style: .insetGrouped)

    var ingredientsList: Observable<[String]> = Observable(["tomato"])

    var recipes: Observable<[RecipeModel]> = Observable([])

    init() {
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func request() {
        if ingredientsList.value.isEmpty == false {
            NetworkService.shared.fetchData(entries: ingredientsList.value) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.error.value = error.localizedDescription
                    print(error)
                case .success(let receivedRecipes):
                    self?.recipes.value = receivedRecipes
                }
            }
        } else {
            
            // here vm must notify that something went wrong
        
        }
    }
}
