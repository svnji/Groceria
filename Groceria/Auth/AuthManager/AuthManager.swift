//
//  AuthManager.swift
//  Groceria
//
//  Created by Daddy on 18/03/2026.
//

import Foundation
import UIKit

final class AuthManager {

    static let shared = AuthManager()

    private let http = HTTPClint()

    private let tokenKey = "authAccessToken"
    private let tokenTypeKey = "authTokenType"

    private init() {}

    private var deviceImei: String {
        if let id = UIDevice.current.identifierForVendor?.uuidString { return id }

        let key = "groceria_device_imei_fallback"
        if let existing = UserDefaults.standard.string(forKey: key) {
            return existing
        }

        let fresh = UUID().uuidString
        UserDefaults.standard.set(fresh, forKey: key)
        return fresh
    }

    private var devicePushToken: String {
        UserDefaults.standard.string(forKey: "fcm_push_token") ?? "pending-device-token"
    }

    private let deviceType = "apple"

    func register(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        passwordConfirmation: String
    ) async throws -> AuthSessionResponse {

        let body = RegistrationRequest(
            nameFirst: firstName,
            nameLast: lastName,
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation,
            imei: deviceImei,
            token: devicePushToken,
            deviceType: deviceType,
            code: ""
        )

        let session = try await http.register(body)
        try persistSession(session)
        return session
    }

    func login(email: String, password: String) async throws -> AuthSessionResponse {

        let body = LoginRequest(
            email: email,
            password: password,
            imei: deviceImei,
            token: devicePushToken,
            deviceType: deviceType
        )

        let session = try await http.login(body)
        try persistSession(session)
        return session
    }

    var accessToken: String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }

    var tokenType: String? {
        UserDefaults.standard.string(forKey: tokenTypeKey)
    }

    func signOut() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: tokenTypeKey)
        UserDefaults.standard.removeObject(forKey: "firstName")
        UserDefaults.standard.removeObject(forKey: "lastName")
    }

    private func persistSession(_ session: AuthSessionResponse) throws {
        let user = session.data.user

        UserDefaults.standard.set(session.data.accessToken, forKey: tokenKey)
        UserDefaults.standard.set(session.data.tokenType, forKey: tokenTypeKey)
        UserDefaults.standard.set(user.nameFirst, forKey: "firstName")
        UserDefaults.standard.set(user.nameLast, forKey: "lastName")
    }
}
