//
//  Ingredient.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

// MARK: - Ingredient

struct Ingredient: Decodable {
    let text: String
    let quantity: Float
    let measure: String?
    let food: String
    let weight: Float
    let foodID: String

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight
        case foodID = "foodId"
    }
}
