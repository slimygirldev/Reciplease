//
//  Recipe.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

struct Recipe: Codable {
    let uri, label, image: String
    let images: Images
    let source, url, shareAs: String
    let yield: Int
    let dietLabels, healthLabels, cautions, ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, glycemicIndex, totalCO2Emissions: Int
    let co2EmissionsClass: String
    let totalWeight: Int
    let cuisineType, mealType, dishType, instructions: [String]
    let tags: [String]
    let externalID: String
    let totalNutrients, totalDaily: TotalDaily
    let digest: [Digest]

    enum CodingKeys: String, CodingKey {
        case uri, label, image, images, source, url, shareAs, yield, dietLabels, healthLabels, cautions, ingredientLines, ingredients, calories, glycemicIndex, totalCO2Emissions, co2EmissionsClass, totalWeight, cuisineType, mealType, dishType, instructions, tags
        case externalID = "externalId"
        case totalNutrients, totalDaily, digest
    }
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag, schemaOrgTag: String
    let total: Int
    let hasRDI: Bool
    let daily: Int
    let unit: String
    let sub: TotalDaily
}

struct TotalDaily: Codable {
}


