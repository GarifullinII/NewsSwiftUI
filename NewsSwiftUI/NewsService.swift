//
//  NewsService.swift
//  NewsSwiftUI
//
//  Created by Ildar Garifullin on 17.03.2026.
//

import Foundation

final class NewsService {

    private let apiKey = "**********"

    func fetchNews(query: String,
                   completion: @escaping (Result<[Article], Error>) -> Void) {

        var components = URLComponents(string: "https://newsapi.org/v2/everything")!
        
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "pageSize", value: "10"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

        guard let url = components.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No data", code: -1)))
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded.articles))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}

struct NewsResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable, Hashable {
    let title: String?
    let description: String?
    let urlToImage: String?
}
