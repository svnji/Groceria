//
//  HTTPClint.swift
//  Groceria
//
//  Created by Daddy on 01/04/2026.
//

import Foundation

enum HTTPClientError: LocalizedError {
    case invalidResponse
    case serverError(String)
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid server response."
        case .serverError(let message):
            return message
        case .decodingFailed:
            return "Could not decode response."
        }
    }
}

struct HTTPClint {

    func register(_ body: RegistrationRequest) async throws -> AuthSessionResponse {
        try await post(url: K.Urls.register, body: body)
    }

    func login(_ body: LoginRequest) async throws -> AuthSessionResponse {
        try await post(url: K.Urls.login, body: body)
    }

    private func post<T: Encodable, R: Decodable>(
        url: URL,
        body: T
    ) async throws -> R {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }

        if let envelope = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let status = envelope["status"] as? String,
           status == "error",
           let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
            throw HTTPClientError.serverError(apiError.flattenedMessage)
        }

        guard (200...299).contains(http.statusCode) else {
            let msg = String(data: data, encoding: .utf8) ?? "Request failed"
            throw HTTPClientError.serverError(msg)
        }

        return try JSONDecoder().decode(R.self, from: data)
    }
}
