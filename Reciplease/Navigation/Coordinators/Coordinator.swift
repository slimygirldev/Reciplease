//
//  Coordinator.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 18/01/2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}

protocol Coordinated {
    var coordinator: MainCoordinator { get set }
}
