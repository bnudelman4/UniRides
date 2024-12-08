//
//  Image.swift
//  UniRides
//
//  Created by Benjamin Nudelman on 12/7/24.
//

struct Img: Codable{
    let timeCreated: String
    let id: Int
    let url: String

    enum CodingKeys: String, CodingKey {
            case timeCreated = "created_at"
            case id
            case url
        }
}
