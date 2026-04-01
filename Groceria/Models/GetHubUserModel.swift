import Foundation

struct GetHubUserModel: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}

enum GHError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}
