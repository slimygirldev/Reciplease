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

    var ingredientsList: [String] = ["tomato"]

    var recipes: [RecipeModel] = []

    init() {
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func request() {
        if ingredientsList.isEmpty == false {
            NetworkService.shared.fetchData(entries: ingredientsList) { [weak self] result in
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
