//
//  SearchCoordinator.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 18/01/2023.
//

import UIKit

class SearchCoordinator: MainCoordinator {

    override func start() {
        let viewController = SearchViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
