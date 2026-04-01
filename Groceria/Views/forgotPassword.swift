//
//  forgotPassword.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//

import SwiftUI

struct forgotPassword: View {
    
    @StateObject private var vm = ForgotPasswordViewModel()
    @State var goToCreate = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 1) {
                Text("Forgot Password")
                    .font(.custom("PlusJakartaSans-Bold", size: 24))
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Recover your account password")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 34)
                    .foregroundStyle(.grayScale70)
            }
            
            K.AppTextField(title: "E-mail", placeHolder: "Enter your email", text: $vm.email)
            
            K.ButtonView(imageName: "", text: "Continue") {
                vm.continueFlow {
                    goToCreate = true
                }
            }
            
        }
        Spacer()
            .navigationDestination(isPresented: $goToCreate) {
                CreateNewPassword()
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
    forgotPassword()
}
