//
//  Image.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

// MARK: - Images

struct Images: Decodable {
    let thumbnail: Large
    let small: Large
    let regular: Large
    let large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

// MARK: - Large

struct Large: Decodable {
    let url: String
    let width: Int
    let height: Int
}
