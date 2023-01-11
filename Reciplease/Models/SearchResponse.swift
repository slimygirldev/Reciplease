//
//  SearchResponse.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let from: Int
    let to: Int
    let count: Int
    let links: Links
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    let links: Links

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - Links
struct Links: Codable {
//    let linksSelf: Next
    let next: Next

    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
        case next
    }
}

// MARK: - Next
struct Next: Codable {
    let href: String
    let title: String
}

