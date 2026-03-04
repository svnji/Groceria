//
//  SignInView.swift
//  Groceria
//
//  Created by Daddy on 04/03/2026.
//

import SwiftUI

struct SignInView: View {
    
    @State private var isClicked = false
    
    @State private var emailTextFieldText = ""
    
    @State private var passwordTextFieldText = ""
    
    @State private var goToSignup = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Sign In")
                    .font(.custom("PlusJakartaSans-Bold", size: 18))
                    .padding(43)
                
                K.AppTextField(title: "Email Address", placeHolder: "Enter your email address", text: $emailTextFieldText)
                
                K.AppTextField(title: "Password", placeHolder: "Enter your password", text: $passwordTextFieldText)
                
                HStack {
                    HStack {
                        Image(systemName:
                                isClicked ? "checkmark.circle.fill" : "circle"
                        )
                        .foregroundStyle(.primaryApp)
                        .onTapGesture {
                            isClicked.toggle()
                        }
                        
                        Text("Remember Me")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                            .foregroundStyle(.grayScale70)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Forgot Password")
                            .foregroundStyle(.error)
                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                    }
                    
                }
                .padding(.horizontal, 24)
                
                K.ButtonView(imageName: "", text: "Sign In") {
                    
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
        }
    }
}



#Preview {
    SignInView()
}
