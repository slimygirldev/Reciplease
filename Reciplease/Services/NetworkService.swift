//
//  NetworkService.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case unexpectedStatusCode
    case noData
}

class NetworkService: NetworkProtocol {

    private let apiKey: String = ""
    private let recipeUrl: String = "https://api.edamam.com/api/recipes/v2?"
    private let id: String = ""
    private let type: String = "public"

    var networkClient: URLSession

    init(networkClient: URLSession) {
        self.networkClient = networkClient
    }

    func fetchData(entries: [String],
                   completion: @escaping (Result<[SearchResponse], Error>) -> Void) {

        //Check for empty
        let validEntries = entries.filter({ !$0.isEmpty })

        //Check for problematic characters like spaces or special characters
        var urlComponents = URLComponents(string: recipeUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: validEntries.joined(separator: ",")),
            URLQueryItem(name: "app_id", value: id),
            URLQueryItem(name: "app_key", value: apiKey),
            URLQueryItem(name: "type", value: type)
        ]

        guard let urlComponents = urlComponents,
              let url = urlComponents.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = networkClient.dataTask(with: request) { data, response, error in
            //Handling response and error
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                // Create array of response
                var result: [SearchResponse] = []
                // Use append method to add a decoded response element to the result array
                result.append(searchResponse)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
