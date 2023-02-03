//
//  Recipe.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

// MARK: - Recipe

struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let images: Images
    let url: String
    let shareAs: String
    let ingredientLines: [String]
    let ingredients: [Ingredient]
}
