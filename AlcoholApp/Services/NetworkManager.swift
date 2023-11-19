//
//  NetworkManager.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 14.11.2023.
//

import Foundation
import Alamofire

var url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic" )!


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCoctail(from url: URL , completion: @escaping(Result<[Drink], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let drinks = Drink.getCoctail(from: value)
                    completion(.success(drinks))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    func fetchData(from url: String,completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { DataResponse in
                switch DataResponse.result {
                    
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
   
    
}

