//
//  Recipe.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let images: Images
    let source: String
    let url: String
    let shareAs: String
    let ingredientLines: [String]
    let ingredients: [Ingredient]
}


