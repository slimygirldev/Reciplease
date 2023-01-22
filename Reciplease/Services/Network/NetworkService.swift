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

    static let shared = NetworkService(networkClient: .shared)

    private let type: String = "public"

    var networkClient: URLSession

     private init(networkClient: URLSession) {
        self.networkClient = networkClient
    }

    func fetchData(entries: [String],
                   completion: @escaping (Result<[RecipeModel], Error>) -> Void) {
        //Check for empty
        // check if entries has values
        let validEntries = entries.filter({ !$0.isEmpty })

        //Check for problematic characters like spaces or special characters
        var urlComponents = URLComponents(string: Config.recipeUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: validEntries.joined(separator: ",")),
            URLQueryItem(name: "app_id", value: Config.id),
            URLQueryItem(name: "app_key", value: Config.apiKey),
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
            print(String(decoding: data, as: UTF8.self))

            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)

                let recipeModel = searchResponse.hits.map { hit -> RecipeModel in
                    let recipe = hit.recipe
                    return RecipeModel(title: recipe.label,
                                       duration: 30,
                                       ingredients: recipe.ingredients.map{ $0.food },
                                       note: 4.5,
                                       image: recipe.images.large.url)
                }
//                let recipes = searchResponse.hits.map { $0.recipe }
                completion(.success(recipeModel))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
