//
//  NetworkManager.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 14.11.2023.
//

import Foundation

var url: URL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic" )!


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    

    
    func Info<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
