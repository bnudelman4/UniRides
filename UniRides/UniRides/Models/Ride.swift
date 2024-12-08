struct Ride: Codable {
    let id: Int
    let startLocation: String
    let endLocation: String
    let startTime: String
    let totalCapacity: Int
    let spacesLeft: Int
    let price: Double
    let carType: String
    let licensePlate: String
    let image: Img
    let driver: User
    let currentRiders: [User]
    let pendingRiders: [User]

    enum CodingKeys: String, CodingKey {
        case id
        case startLocation = "start_location"
        case endLocation = "end_location"
        case startTime = "start_time"
        case totalCapacity = "total_capacity"
        case spacesLeft = "available_seats"
        case price
        case carType = "car_type"
        case licensePlate = "license_plate"
        case image
        case driver
        case currentRiders = "current_riders"
        case pendingRiders = "pending_riders"
    }
}
