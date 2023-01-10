//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

class SearchViewModel {

    private let networkService: NetworkService

    var ingredientsList: [String] = []

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func request() {
        networkService.fetchData(entries: ingredientsList) { result in
            print(result)
        }
    }
}
