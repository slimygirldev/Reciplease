//
//  MainCoordinator.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 18/01/2023.
//

import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {}

    // ici mettre les fonctions de navigation
    func goToRecipePage(_ recipeList: [RecipeModel] ) {
        let controller = RecipeListViewController()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
