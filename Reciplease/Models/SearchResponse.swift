//
//  SearchResponse.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

// MARK: - SearchResponse

struct SearchResponse: Decodable {
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

struct Hit: Decodable {
    let recipe: Recipe
    let links: Links

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - Links

struct Links: Decodable {
    let next: Next?

    enum CodingKeys: String, CodingKey {
        case next
    }
}

// MARK: - Next

struct Next: Decodable {
    let href: String
    let title: String
}

