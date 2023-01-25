//
//  NetworkService.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 09/01/2023.
//

import Alamofire
import AlamofireImage
import Foundation

enum APIError: Error {
    case invalidURL
    case unexpectedStatusCode
    case noData
}

class NetworkService {

    static let shared = NetworkService()

    private let type: String = "public"

    init() {
    }

    func fetchData(entries: [String],
                   completion: @escaping (Result<[RecipeModel], Error>) -> Void) {
        //Check for empty
        //check if entries has values
        let validEntries = entries.filter({ !$0.isEmpty })
        //Creating parameters for AF parameters
        let parameters = ["q": validEntries.joined(separator: ","),
                          "app_id": Config.id,
                          "app_key": Config.apiKey,
                          "type": type]

        guard let url = URL(string: Config.recipeUrl) else {
            return
        }

        AF.request(url, method: .get,
                   parameters: parameters)
        .responseDecodable(of: SearchResponse.self) { [weak self] response in
            switch response.result {
            case .success(let searchResponse):
                var recipeModel = [RecipeModel]()
                for hit in searchResponse.hits {
                    let recipe: Recipe = hit.recipe
                    let imageUrl: String = recipe.images.large?.url ?? ""
                    self?.downloadImage(from: imageUrl) { image in
                        let recipe: RecipeModel = RecipeModel(title: recipe.label,
                                                              duration: 30,
                                                              ingredients: recipe.ingredients.map{ $0.food },
                                                              note: 4.5,
                                                              image: image)
                        recipeModel.append(recipe)
                        if recipeModel.count == searchResponse.hits.count {
                            completion(.success(recipeModel))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("image.jpg")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(url, to: destination)
            .responseData { response in
                if let data = response.value {
                    let image = UIImage(data: data)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
    }
}
