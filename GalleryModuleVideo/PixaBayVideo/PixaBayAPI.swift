//
//  Controller.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 29/10/23.
//

import Foundation

class PixaBayAPI {
    
    private let apiKey = "40347283-4c0785f2b24dbd816fa75233b"
    private let baseUrl = "https://pixabay.com/api/videos/"

    func searchForVideos(completion: @escaping (Result<Root, Error>) -> Void) {
        var urlComponents = URLComponents(string: baseUrl)!
        
        let queryParameters = [
            "key": apiKey,
            "page": String(1), // page starts from 1
            "per_page": String(5), // per page 3 - 20, default: 20
            "lang": "da",
            "video_type": "all",
            "category" : "nature",
            "min_width": String(2000),
            "min_height": String(2000),
            "editors_choice": String(true),
            "safesearch": String(true),
            "order": "popular",
            "q": "mountain"
        ]
        
        urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            print("Here jdncjnsddkndknd kdnkn : ",url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Root.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
        
}
