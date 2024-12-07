//
//  Ride.swift
//  UniRides
//
//  Created by Benjamin Nudelman on 12/6/24.
//

struct Ride: Codable {
    let difficulty: String
    let id: String
    let description: String
    let imageUrl: String
    let name: String
    
    let startLocation: String
    let endLocation: String
    let startTime: String
    let spacesLeft: Int
    let price: Double

}
