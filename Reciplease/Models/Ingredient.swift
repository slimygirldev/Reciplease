//
//  Ingredient.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

struct Ingredient: Codable {
    let text: String
    let quantity: Int
    let measure, food: String
    let weight: Int
    let foodID: String

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight
        case foodID = "foodId"
    }
}
