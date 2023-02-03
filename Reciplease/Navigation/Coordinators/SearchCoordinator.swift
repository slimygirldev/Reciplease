//
//  SearchCoordinator.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 18/01/2023.
//

import UIKit

class SearchCoordinator: MainCoordinator {
    // ViewModel creation and injection inside ViewController
    // ViewController creation and presentation
    override func start() {
        let networkService: NetworkService = NetworkService(urlSession: .shared)
        let viewModel: SearchViewModel = SearchViewModel(networkService: networkService)
        let viewController = SearchViewController(viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
