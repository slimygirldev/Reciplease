//
//  NetworkProtocol.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

enum NetworkError: Error {
    case fetchError
}

protocol NetworkProtocol {
    var networkClient: URLSession { get }
    
    func fetchData(entries: [String],
                   completion: @escaping (Result<[SearchResponse], Error>) -> Void)
}
