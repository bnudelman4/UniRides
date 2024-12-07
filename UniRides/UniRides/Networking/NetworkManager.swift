//
//  NetworkManager.swift
//  UniRides
//
//  Created by Benjamin Nudelman on 11/18/24.
//

import Alamofire
import Foundation

class NetworkManager {

    /// Shared singleton instance
    static let shared = NetworkManager()

    private init() { }
    
    //decoder
    let decoder = JSONDecoder()
//
    // MARK: - Requests
    func fetchAllRecipes(completion: @escaping ([Recipe]) -> Void){
        let devEndpoint: String = "https://api.jsonbin.io/v3/b/64d033f18e4aa6225ecbcf9f?meta=false"
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(devEndpoint, method: .get).validate().responseDecodable(of: [Recipe].self, decoder: decoder){
            response in switch response.result {
            case .success(let recipes):
                print("Successfully fetched recipes: \(recipes)")
                completion(recipes)
            case .failure(let error):
                print("Error fetching recipes: \(error)")
            }
        }
        
    }
    
}
