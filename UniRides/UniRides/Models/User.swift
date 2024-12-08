//
//  User.swift
//  UniRides
//
//  Created by Benjamin Nudelman on 12/7/24.
//


struct User: Codable{
    let email: String
    let firstName: String
//    let fullName: String
    let id: Int
    let lastName: String
    let phoneNumber: String
//    let password: String
    
    enum CodingKeys: String, CodingKey {
            case email
            case firstName = "first_name"
//            case fullName = "full_name"
            case id
            case lastName = "last_name"
            case phoneNumber = "phone_number"
//            case password = "password"
        }
}
