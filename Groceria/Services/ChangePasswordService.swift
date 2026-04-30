//
//  ChangePasswordService.swift
//  Groceria
//
//  Created by Daddy on 29/04/2026.
//


import Foundation

struct ChangePasswordRequest: Encodable {
    let password: String
    let password_confirmation: String
}

struct ChangePasswordResponse: Decodable {
    let message: String
    let success: Bool
}

enum ChangePasswordError: LocalizedError {
    case invalidURL
    case invalidResponse
    case unauthenticated
    case serverError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:            return "Invalid URL."
        case .invalidResponse:       return "Invalid server response."
        case .unauthenticated:       return "User is not authenticated."
        case .serverError(let msg):  return msg
        }
    }
}

class ChangePasswordService {
    static let shared = ChangePasswordService()
    private init() {}

    private let baseURL = K.Urls.base

    func changePassword(
        newPassword: String,
        confirmPassword: String
    ) async throws -> ChangePasswordResponse {

        guard let token = AuthManager.shared.accessToken else {
            throw ChangePasswordError.unauthenticated
        }

        let tokenType = AuthManager.shared.tokenType ?? "Bearer"

        guard let url = URL(string: "\(baseURL)/profile/change/password") else {
            throw ChangePasswordError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(tokenType) \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(
            ChangePasswordRequest(
                password: newPassword,
                password_confirmation: confirmPassword
            )
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw ChangePasswordError.invalidResponse
        }

        return try JSONDecoder().decode(ChangePasswordResponse.self, from: data)
    }
}
