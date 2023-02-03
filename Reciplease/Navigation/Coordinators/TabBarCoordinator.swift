//
//  TabBarCoordinator.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 18/01/2023.
//

import UIKit

class TabBarCoordinator {

    // MARK: - Properties

    var tabBarController: TabBarViewController

    // MARK: - Methods

    init(_ navigation: TabBarViewController) {
        self.tabBarController = navigation
    }
    func start() {
        let firstNavigationController = UINavigationController()

        let firstCoordinator = SearchCoordinator(navigationController: firstNavigationController)
        firstCoordinator.start()

        let secondNavigationController = UINavigationController()

        let secondCoordinator = FavoritesCoordinator(navigationController: secondNavigationController)
        secondCoordinator.start()

        tabBarController.viewControllers = [
            firstNavigationController,
            secondNavigationController
        ]
        tabBarController.viewControllers?.forEach {
            $0.edgesForExtendedLayout = []
        }
    }
}
