//
//  AuthManager.swift
//  Groceria
//
//  Created by Daddy on 18/03/2026.
//

import Foundation
import FirebaseAuth

class AuthManager {

    static let shared = AuthManager()
    private init() {}

    // MARK: - Sign Up
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {

        Auth.auth().createUser(withEmail: email, password: password) { result, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            if let user = result?.user {
                completion(.success(user))
            }
        }
    }

    // MARK: - Sign In
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { result, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            if let user = result?.user {
                completion(.success(user))
            }
        }
    }

    // MARK: - Logout
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
