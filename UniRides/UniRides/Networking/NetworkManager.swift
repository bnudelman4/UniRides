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

    struct RideResponse: Decodable {
        let carpools: [Ride]
    }
    
    // MARK: - Requests
    func fetchAllRides(completion: @escaping ([Ride]) -> Void) {
        let devEndpoint: String = "http://34.150.195.46:80/api/carpools/all/"
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        print("got here")
        AF.request(devEndpoint, method: .get).validate().responseDecodable(of: RideResponse.self, decoder: decoder) { response in
            switch response.result {
            case .success(let rideResponse):
                print("Successfully fetched rides: \(rideResponse.carpools)")
                completion(rideResponse.carpools)
            case .failure(let error):
                print("Error fetching rides: \(error)")
            }
        }
//        AF.request(devEndpoint, method: .get).validate().response { response in
//            if let error = response.error {
//                print("Error fetching rides: \(error.localizedDescription)")
//            } else {
//                print("Response Status Code: \(response.response?.statusCode ?? -1)")
//                if let data = response.data {
//                    print("Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
//                }
//            }
//        }
        
//        AF.request(devEndpoint, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let json):
//                print("Raw JSON Response: \(json)")
//            case .failure(let error):
//                print("Error fetching rides: \(error)")
//            }
//        }
    }
    
    func addToUsers(user: User, completion: @escaping ((User) -> Void)) {
            let devEndpoint: String = "http://34.150.195.46:80/api/users/"
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let parameters: Parameters = [
                "email": user.email,
//                "password": user.password,
                "first_name": user.firstName,
                "id": user.id,
                "last_name": user.lastName,
                "phone_number": user.phoneNumber
            ]
            
            AF.request(devEndpoint, method: .post, parameters: parameters)
                .validate()
                .responseDecodable(of: User.self, decoder: decoder){response in
                    switch response.result {
                    case .success(let user):
                        print("Successfully added user: \(user.id) to the user array")
                        completion(user)
                    case .failure(let error):
                        print("Error in NetworkManager.addToUsers: \(error.localizedDescription)")
                    }
                }
//        AF.request(devEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .success(let data):
//                    print("Success: \(data)")
//                case .failure(let error):
//                    print("Request failed: \(error)")
//                    if let statusCode = response.response?.statusCode {
//                        print("Status code: \(statusCode)")
//                    }
//                }
//            }

        }
}
