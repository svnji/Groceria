//
//  CartService.swift
//  Groceria
//
//  Created by Daddy on 17/04/2026.
//

import Foundation

final class CartService {

    static let shared = CartService()
    private init() {}

    private let cartsURL = K.Urls.base.appendingPathComponent("carts")

    private var authorizationHeader: String? {
        guard let token = AuthManager.shared.accessToken else { return nil }
        let type = AuthManager.shared.tokenType ?? "Bearer"
        return "\(type) \(token)"
    }

    // MARK: - Fetch Cart
    func fetchCart() async throws -> CartData {
        var request = URLRequest(url: cartsURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let authorizationHeader {
            request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        }

        let data = try await perform(request)
        let decoded = try JSONDecoder().decode(CartResponse.self, from: data)
        return decoded.data
    }

    // MARK: - Add To Cart
    func addToCart(productId: Int, amount: Int = 1) async throws {
        try await upsertCart(productId: productId, amount: amount, isAddition: 1)
    }

    // MARK: - Set Cart Quantity
    func setQuantity(productId: Int, amount: Int) async throws {
        try await upsertCart(productId: productId, amount: amount, isAddition: 0)
    }

    // MARK: - Remove From Cart
    func removeFromCart(cartItemId: Int) async throws {
        let removeURL = cartsURL.appendingPathComponent("\(cartItemId)")
        var request = URLRequest(url: removeURL)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let authorizationHeader {
            request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        }

        _ = try await perform(request)
    }

    private func upsertCart(productId: Int, amount: Int, isAddition: Int) async throws {
        var request = URLRequest(url: cartsURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(
            AddToCartRequest(
                amount: amount,
                productId: productId,
                isAddition: isAddition
            )
        )

        if let authorizationHeader {
            request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        }

        _ = try await perform(request)
    }

    private func perform(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }

        guard (200...299).contains(http.statusCode) else {
            if let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                throw HTTPClientError.serverError(apiError.flattenedMessage)
            }
            let message = String(data: data, encoding: .utf8) ?? "Request failed"
            throw HTTPClientError.serverError(message)
        }

        return data
    }
}

private struct AddToCartRequest: Encodable {
    let amount: Int
    let productId: Int
    let isAddition: Int

    enum CodingKeys: String, CodingKey {
        case amount
        case productId = "product_id"
        case isAddition = "is_addition"
    }
}
