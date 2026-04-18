//
//  RegisterView.swift
//  Groceria
//
//  Created by Daddy on 04/03/2026.
//

import SwiftUI

struct RegisterView: View {

    @Environment(\.dismiss) private var dismiss

    @AppStorage("isLoggedIn") private var isLoggedIn = false

    @StateObject private var vm = RegisterViewModel()

    @State private var goToLogin = false
    @State private var errorMessage: String?

    var body: some View {

        ScrollView {
            VStack {

                Text("Create your account")
                    .font(.custom("PlusJakartaSans-Bold", size: 24))
                    .padding()

                VStack {

                    K.AppTextField(
                        title: "First Name",
                        placeHolder: "Enter your first name",
                        text: $vm.firstNameTextFieldText
                    )

                    K.AppTextField(
                        title: "Last Name",
                        placeHolder: "Enter your last name",
                        text: $vm.lastNameTextFieldText
                    )

                    K.AppTextField(
                        title: "Email",
                        placeHolder: "Enter your email",
                        text: $vm.email
                    )

                    K.AppTextField(
                        title: "Password",
                        placeHolder: "Enter your password",
                        text: $vm.password
                    )

                    K.AppTextField(
                        title: "Confirm Password",
                        placeHolder: "Enter your password",
                        text: $vm.confirmPassword
                    )
                }

                if let errorMessage {
                    Text(errorMessage)
                        .font(.custom("PlusJakartaSans-Medium", size: 13))
                        .foregroundStyle(.error)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                K.ButtonView(imageName: "", text: "Sign Up") {
                    errorMessage = nil
                    vm.signUp { result in
                        switch result {
                        case .success:
                            isLoggedIn = true
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                        }
                    }
                }

                HStack(spacing: 4) {
                    Text("Already have an account?")
                        .foregroundStyle(.gray)

                    Button("Login") {
                        goToLogin = true
                    }
                    .foregroundStyle(.primaryApp)
                }
            }
            .padding()
        }

        .navigationDestination(isPresented: $goToLogin) {
            SignInView()
        }

        .navigationBarTitleDisplayMode(.inline)
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
    RegisterView()
}
