//
//  AlertProvider.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 12/01/2023.
//

import Foundation
import UIKit

// MARK: - Error messages

enum AlertMessages: String {
    case noIngredient = "Please enter an ingredient."
    case noData = "No recipes found for the selected ingredients. Please try again with different ingredients."
    case invalidURL = "Invalid URL. Please check the URL and ensure that it is formatted correctly and leads to a valid endpoint."
    case unexpectedStatusCode = "Unexpected status code received from API endpoint. Please check your request and ensure that the API endpoint is functioning properly."
}

class AlertProvider: Error {

    // MARK: - Methods
    
    func alertError(alertType: APIError) -> UIAlertController {
        switch alertType {
        case .noData:
            let alertVC = UIAlertController(title: "Error",
                                            message: AlertMessages.noData.rawValue,
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            return alertVC
        case .unexpectedStatusCode:
            let alertVC = UIAlertController(title: "Error",
                                            message: AlertMessages.unexpectedStatusCode.rawValue,
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            return alertVC
        case .invalidURL:
            let alertVC = UIAlertController(title: "Error",
                                            message: AlertMessages.invalidURL.rawValue,
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            return alertVC
        case .noIngredients:
            let alertVC = UIAlertController(title: "Error",
                                            message: AlertMessages.noIngredient.rawValue,
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            return alertVC
        }
    }
}
