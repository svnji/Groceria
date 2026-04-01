//
//  CreateNewPassword.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//

import SwiftUI

struct CreateNewPassword: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @StateObject private var vm = CreateNewPasswordViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack {
                Text("Create a New Password")
                    .font(.custom("PlusJakartaSans-Bold", size: 24))
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Enter your new password")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 34)
                    .foregroundStyle(.grayScale70)
            }
            .padding(.vertical, 50)
            
            K.AppTextField(title: "New Password", placeHolder: "Enter new password", text: $vm.newPasswordText)
            
            K.AppTextField(title: "Confirm Password", placeHolder: "Enter new password", text: $vm.confirmPasswordText)
            
            K.ButtonView(imageName: "", text: "Continue") {
                if vm.canContinue {
                    isLoggedIn = true
                }
            }
        }
        Spacer()
        
        
        
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
    CreateNewPassword()
}
