//
//  AuthController.swift
//  Groceria
//
//  Created by Daddy on 01/04/2026.
//

import Foundation

struct AuthController {

    func register(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        passwordConfirmation: String
    ) async throws -> AuthSessionResponse {
        try await AuthManager.shared.register(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation
        )
    }
}
