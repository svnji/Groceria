//
//  SignInView.swift
//  Groceria
//
//  Created by Daddy on 04/03/2026.
//

import SwiftUI

struct SignInView: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    
    @State private var goToForgetPassword = false
    @State private var goToSignup = false
    @State private var goToHome = false
    
    @StateObject private var vm = SignInViewModel()
    
    var body: some View {
            ScrollView {
                VStack {
                    Text("Sign In")
                        .font(.custom("PlusJakartaSans-Bold", size: 18))
                        .padding(43)
                    
                    K.AppTextField(title: "Email Address", placeHolder: "Enter your email address", text: $vm.email)
                    
                    K.AppTextField(title: "Password", placeHolder: "Enter your password", text: $vm.password)
                    
                    HStack {
                        HStack {
                            Image(systemName:
                                    vm.isRememberMeEnabled ? "checkmark.circle.fill" : "circle"
                            )
                            .foregroundStyle(.primaryApp)
                            .onTapGesture {
                                vm.toggleRememberMe()
                            }
                            
                            Text("Remember Me")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                                .foregroundStyle(.grayScale70)
                        }
                        Spacer()
                        Button {
                            goToForgetPassword = true
                        } label: {
                            Text("Forgot Password")
                                .foregroundStyle(.error)
                                .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    K.ButtonView(imageName: "", text: "Sign In") {
                        vm.signIn { success in
                            if success {
                                isLoggedIn = true
                                goToHome = true
                            }
                        }
                    }
                    
                    HStack {
                        Rectangle()
                            .frame(width: 62, height: 2)
                        Text("Or continue with")
                        Rectangle()
                            .frame(width: 62, height: 2)
                    }
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    
                    VStack {
                        Button {
                        } label: {
                            HStack {
                                Image("GoogleLogo")
                                Text("Continue with Google")
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .strokeBorder(.black)
                            )
                        }
                        .padding()
                        
                        Button {
                        } label: {
                            HStack {
                                Image("AppleLogo")
                                Text("Continue with Apple")
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .strokeBorder(.black)
                            )
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundStyle(.gray)
                        
                        Button("Sign Up") {
                            goToSignup = true
                        }
                        .foregroundStyle(.primaryApp)
                    }
                    .padding()
                }
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $goToSignup) {
                    RegisterView()
                }
                .navigationDestination(isPresented: $goToForgetPassword) {
                    forgotPassword()
                }
                .navigationDestination(isPresented: $goToHome) {
                    HomeView()
                }
            }
        }
}

#Preview {
    SignInView()
}
