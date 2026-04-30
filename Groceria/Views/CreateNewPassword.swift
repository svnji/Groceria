//
//  CreateNewPassword.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//
import SwiftUI

struct CreateNewPassword: View {
    @StateObject private var viewModel = CreateNewPasswordViewModel()
    @Environment(\.dismiss) private var dismiss

    var userToken: String = ""

    var body: some View {
        VStack(spacing: 0) {

            VStack(spacing: 8) {
                Image(systemName: "lock.rotation")
                    .font(.system(size: 60))
                    .foregroundColor(.primaryApp)

                Text("Create New Password")
                    .font(.custom("PlusJakartaSans-Medium", size: 22))
                    .foregroundStyle(.grayScale70)

                Text("Your new password must be at least 8 characters.")
                    .font(.custom("PlusJakartaSans-Medium", size: 14))
                    .foregroundStyle(.grayScale60)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            .padding(.top, 40)
            .padding(.bottom, 32)

            K.AppTextField(
                title: "New Password",
                placeHolder: "Enter new password",
                text: $viewModel.newPassword
            )

            K.AppTextField(
                title: "Confirm Password",
                placeHolder: "Re-enter new password",
                text: $viewModel.confirmPassword
            )

            Group {
                if let error = viewModel.errorMessage {
                    Label(error, systemImage: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.custom("PlusJakartaSans-Medium", size: 13))
                }

                if let success = viewModel.successMessage {
                    Label(success, systemImage: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.custom("PlusJakartaSans-Medium", size: 13))
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .padding()
            } else {
                K.ButtonView(imageName: "", text: "Update Password") {
                    Task {
                        await viewModel.changePassword()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    K.BackButtonView()
                }
            }
        }
    }
}

#Preview {
        CreateNewPassword(userToken: AuthManager.shared.accessToken ?? "")
}
