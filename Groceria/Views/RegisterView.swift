//
//  RegisterView.swift
//  Groceria
//
//  Created by Daddy on 04/03/2026.
//

import SwiftUI

struct RegisterView: View {

    @Environment(\.dismiss) private var dismiss

    @AppStorage("firstName") var firstNameTextFieldText: String = ""
    @AppStorage("lastName") var lastNameTextFieldText: String = ""
    @StateObject private var vm = RegisterViewModel()

    @State private var goToLogin = false
    @State private var goToOtp = false

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
                        text: $firstNameTextFieldText
                    )

                    K.AppTextField(
                        title: "Last Name",
                        placeHolder: "Enter your last name",
                        text: $lastNameTextFieldText
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

                K.ButtonView(imageName: "", text: "Sign Up") {
                    vm.signUp { success in
                        if success {
                            goToOtp = true
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

        // Navigation destinations
        .navigationDestination(isPresented: $goToOtp) {
            OTPView()
        }
        .navigationDestination(isPresented: $goToLogin) {
            SignInView()
        }

        // Navigation modifiers OUTSIDE ScrollView
        //.navigationTitle("Sign Up")
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
