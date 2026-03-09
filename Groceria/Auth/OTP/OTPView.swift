//
//  OTPView.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//

import SwiftUI

struct OTPView: View {

    // MARK: - Properties

    @State private var showOverlay = false
    @Environment(\.dismiss) private var dismiss
    @State private var enterValue: [String]
    @FocusState private var fieldFocus: Int?
    
    
    // MARK: - Init

    init() {
        _enterValue = State(initialValue: Array(repeating: "", count: 4))
    }

    // MARK: - Body

    var body: some View {

        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: Title Section
                    VStack(spacing: 8) {
                        
                        Text("Enter OTP")
                            .font(.custom("PlusJakartaSans-Bold", size: 24))
                        
                        Text("We have just sent you 4 digit code via your email **example@gmail.com**")
                            .font(.custom("PlusJakartaSans-Medium", size: 14))
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                    }
                    
                    // MARK: OTP Fields
                    HStack(spacing: 12) {
                        
                        ForEach(0..<4, id: \.self) { index in
                            
                            TextField("", text: $enterValue[index])
                                .frame(width: 56, height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .strokeBorder(.primaryApp, lineWidth: 1.5)
                                )
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($fieldFocus, equals: index)
                            
                                .onChange(of: enterValue[index]) { _, newValue in
                                    
                                    // Allow only one digit
                                    if newValue.count > 1 {
                                        enterValue[index] = String(newValue.prefix(1))
                                    }
                                    
                                    // Move forward
                                    if !newValue.isEmpty {
                                        if index < 3 {
                                            fieldFocus = index + 1
                                        } else {
                                            fieldFocus = nil
                                            verifyOTP()
                                        }
                                    }
                                    // Move backward
                                    else if index > 0 {
                                        fieldFocus = index - 1
                                    }
                                }
                        }
                    }
                    
                    // Continue Button
                    K.ButtonView(imageName: "", text: "Continue") {
                        withAnimation(.easeInOut) {
                                showOverlay = true
                            }
                    }
                    
                    // Resend Section
                    HStack(spacing: 4) {
                        Text("Didn't receive code?")
                            .foregroundStyle(.gray)
                        
                        Button("Resent Code") {
                            
                        }
                        .foregroundStyle(.primaryApp)
                    }
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    fieldFocus = 0
                }
            }
            .blur(radius: showOverlay ? 8 : 0)
            .disabled(showOverlay)
            
            if showOverlay {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    SuccessView()
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .animation(.easeInOut, value: showOverlay)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
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

    // MARK: - OTP Logic

    private func verifyOTP() {
        let otp = enterValue.joined()
        print("Entered OTP:", otp)
    }
}

#Preview {
    OTPView()
}
