//
//  OTPView.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//

import SwiftUI

struct OTPView: View {

    // MARK: - Properties

    @StateObject private var vm = OTPViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var fieldFocus: Int?

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
                            
                            TextField("", text: $vm.enterValue[index])
                                .frame(width: 56, height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .strokeBorder(.primaryApp, lineWidth: 1.5)
                                )
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($fieldFocus, equals: index)
                            
                                .onChange(of: vm.enterValue[index]) { _, newValue in
                                    fieldFocus = vm.handleOTPChange(at: index, newValue: newValue)
                                }
                        }
                    }
                    
                    // Continue Button
                    K.ButtonView(imageName: "", text: "Continue") {
                        withAnimation(.easeInOut) {
                                vm.showOverlay = true
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
            .blur(radius: vm.showOverlay ? 8 : 0)
            .disabled(vm.showOverlay)
            
            if vm.showOverlay {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    SuccessView()
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .animation(.easeInOut, value: vm.showOverlay)
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
}

#Preview {
    OTPView()
}
