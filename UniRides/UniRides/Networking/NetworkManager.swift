//
//  NetworkManager.swift
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
    func fetchAllRides(completion: @escaping ([Car]) -> Void){
        let devEndpoint: String = "https://api.jsonbin.io/v3/b/64d033f18e4aa6225ecbcf9f?meta=false"
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(devEndpoint, method: .get).validate().responseDecodable(of: [Car].self, decoder: decoder){
            response in switch response.result {
            case .success(let rides):
                print("Successfully fetched rides: \(rides)")
                completion(recipes)
            case .failure(let error):
                print("Error fetching rides: \(error)")
            }
        }
        
    }
    
}
