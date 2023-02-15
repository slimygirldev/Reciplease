//
//  FavoritesCoordinator.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 18/01/2023.
//

import UIKit

class FavoritesCoordinator: MainCoordinator {
    // ViewModel creation and injection inside ViewController
    // ViewController creation and presentation

    override func start() {
        let viewModel: FavoriteViewModel = FavoriteViewModel()
        let viewController = FavoritesViewController(viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
