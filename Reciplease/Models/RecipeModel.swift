//
//  RecipeModel.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 10/01/2023.
//

import Foundation

struct RecipeModel {
    var title: String
    var duration: Double = 30
    var ingredients: [Ingredient]
    var note: Double = 4.5
    var images: Images
}
