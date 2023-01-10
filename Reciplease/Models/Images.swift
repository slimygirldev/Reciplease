//
//  Image.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

struct Images: Codable {
    let thumbnail, small, regular, large: Large

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

struct Large: Codable {
    let url: String
    let width, height: Int
}
