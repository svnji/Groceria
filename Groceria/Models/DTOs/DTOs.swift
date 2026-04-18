//
//  DTOs.swift
//  Groceria
//
//  Created by Daddy on 01/04/2026.
//

import Foundation

// MARK: - Requests

struct RegistrationRequest: Codable {

    let nameFirst: String
    let nameLast: String
    let email: String
    let password: String
    let passwordConfirmation: String
    let imei: String
    let token: String
    let deviceType: String
    let code: String

    enum CodingKeys: String, CodingKey {
        case nameFirst = "name_first"
        case nameLast = "name_last"
        case email
        case password
        case passwordConfirmation = "confirm_password"
        case imei
        case token
        case deviceType = "device_type"
        case code
    }
}

struct LoginRequest: Codable {
    let email: String
    let password: String
    let imei: String
    let token: String
    let deviceType: String

    enum CodingKeys: String, CodingKey {
        case email, password, imei, token
        case deviceType = "device_type"
    }
}

// MARK: - Success response

struct AuthSessionResponse: Codable {
    let status: String
    let message: String
    let data: AuthPayload
}

struct AuthPayload: Codable {
    let user: User
    let accessToken: String
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case user = "data"
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

// MARK: - Error response

struct APIErrorResponse: Codable {
    let status: String
    let message: String
    let errors: [String: [String]]?

    var flattenedMessage: String {
        if let errors, !errors.isEmpty {
            let parts = errors.flatMap { key, vals in vals.map { "\(key): \($0)" } }
            return parts.joined(separator: "\n")
        }
        return message
    }
}

// MARK: - User

struct User: Codable {
    let id: Int
    let nameFirst: String
    let nameLast: String
    let name: String
    let fullName: String
    let username: String?
    let phone: String?
    let email: String
    let isStock: Int
    let isTracking: Int
    let isOffer: Int
    let isAvailable: Int
    let vip: Int
    let countryId: Int
    let cityId: Int?
    let branchId: Int?
    let groupId: Int?
    let addressId: Int?
    let image: String?
    let gender: String?
    let genderName: String?
    let birthDate: String?
    let wallet: Int
    let point: Int
    let locale: String
    let latitude: Double?
    let longitude: Double?
    let polygon: String?
    let active: Int
    let lastActive: String?
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case nameFirst = "name_first"
        case nameLast = "name_last"
        case name
        case fullName = "full_name"
        case username
        case phone
        case email
        case isStock = "is_stock"
        case isTracking = "is_tracking"
        case isOffer = "is_offer"
        case isAvailable = "is_available"
        case vip
        case countryId = "country_id"
        case cityId = "city_id"
        case branchId = "branch_id"
        case groupId = "group_id"
        case addressId = "address_id"
        case image
        case gender
        case genderName = "gender_name"
        case birthDate = "birth_date"
        case wallet
        case point
        case locale
        case latitude
        case longitude
        case polygon
        case active
        case lastActive = "last_active"
        case createdAt = "created_at"
    }
}
