//
//  Recipe.swift
//  UniRides
//
//  Created by Benjamin Nudelman on 11/18/24.
//

struct Recipe: Codable {
    let id: String
    let description: String
    let difficulty: String
    let imageUrl: String
    let name: String
    let rating: Double
}
