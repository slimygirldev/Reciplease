//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func searchViewModelDelegateReloadTableView()

    func searchViewModelDelegateShowError(_error: String)
}

class SearchViewModel {
    weak var delegate: SearchTableViewDelegate?

    var tableView = SearchTableView(frame: .zero, style: .insetGrouped)

    private let networkService: NetworkService

    var ingredientsList: [String] = ["tomato"]

    var recipes: [RecipeModel] = []

    init(networkService: NetworkService) {
        self.networkService = networkService

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func request() {
        if ingredientsList.isEmpty == false {
            networkService.fetchData(entries: ingredientsList) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .failure(let error):
//                    self.delegate?.searchViewModelDelegateShowError(error.localizedDescription)
                    print("error is : \(error.localizedDescription)")
                case .success(let receivedRecipes):
                    self.recipes = receivedRecipes
//                    self.delegate?.searchViewModelDelegateReloadTableView()
                }
            }
        } else {
            
            // here vm must notify that something went wrong
        
        }
    }
}
