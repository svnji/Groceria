//
//  SuccessView.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//

import SwiftUI

struct SuccessView: View {
    @State var goToHome = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 327, height: 413)
                .foregroundStyle(.white)
            
            VStack(spacing: 8) {
                Image("Success")
                
                Text("You have logged in successfully")
                        .font(.custom("PlusJakartaSans-Bold", size: 24))
                        .multilineTextAlignment(.center)
                        .padding()
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .font(.custom("PlusJakartaSans-Medium", size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 34)
                    .foregroundStyle(.commonGray)
                
                
                K.ButtonView(imageName: "", text: "Continue") {
                    goToHome = true
                }
                .padding(.horizontal, 34)
                
                    
                    
            }
            .padding()
        }
        .navigationDestination(isPresented: $goToHome) {
            CustomTabBar()
        }
    }
}

#Preview {
    SuccessView()
}
