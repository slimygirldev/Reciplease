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
    let yield: Int
    let dietLabels: String
    let healthLabels: String
    let cautions: String
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories: Int
    let glycemicIndex: Int
    let totalCO2Emissions: Int
    let co2EmissionsClass: String
    let totalWeight: Int
    let cuisineType: [String]
    let mealType: [String]
    let dishType: [String]
    let instructions: [String]
    let tags: [String]
    let externalID: String
    let totalNutrients: TotalDaily
    let totalDaily: TotalDaily
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


