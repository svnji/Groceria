//
//  CreateNewPasswordViewModel.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//

import Foundation

@MainActor
class CreateNewPasswordViewModel: ObservableObject {
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var successMessage: String?
    @Published var errorMessage: String?

    func changePassword() async {
        errorMessage = nil
        successMessage = nil

        guard !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }

        guard newPassword == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        guard newPassword.count >= 8 else {
            errorMessage = "Password must be at least 8 characters."
            return
        }

        isLoading = true

        do {
            let response = try await ChangePasswordService.shared.changePassword(
                newPassword: newPassword,
                confirmPassword: confirmPassword
            )
            successMessage = response.message
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
