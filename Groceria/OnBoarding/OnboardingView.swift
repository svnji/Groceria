//
//  OnboardingView.swift
//  Groceria
//
//  Created by Daddy on 26/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    @State private var goToRegister = false
    @State private var goSignIn: Bool = false
    @State private var currentPage = 0
    var isLastPage: Bool {
        currentPage == 2
    }
    var subTitle: String {
        switch currentPage {
        case 0:
            return "Convenience for Your Everyday Essentials"
        case 1:
            return "Effortless Access to Daily Necessities"
        case 2:
            return "Daily Grocery Needs, Just a Tap Away"
        default:
            return "Convenience for Your Everyday Essentials"
        }
    }
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: - Title
                Text("Groceria")
                    .font(.custom("PlusJakartaSans-ExtraBold", size: 40))
                    .foregroundStyle(.primaryApp)
                    .padding()
                
                // MARK: - Subtitle
                Text(subTitle)
                    .font(.custom("PlusJakartaSans-Bold", size: 30))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .padding(.horizontal)
                
                // MARK: - Description
                Text("Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem.")
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                
                // MARK: - Page Indicator
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        Capsule()
                            .fill(
                                index == currentPage
                                ? Color.primaryApp
                                : Color.gray.opacity(0.3)
                            )
                            .frame(
                                width: index == currentPage ? 20 : 6,
                                height: 6
                            )
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                .padding(.horizontal)
                
                
                // MARK: - Onboarding Pages
                TabView(selection: $currentPage) {
                    OnboardingPage(imageName: "onboarding1")
                        .tag(0)
                    
                    OnboardingPage(imageName: "onboarding2")
                        .tag(1)
                    
                    OnboardingPage(imageName: "onboarding3")
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // MARK: - Continue Button
                
                .overlay(alignment: .bottom) {
                    
                    VStack(spacing: 12) {
                        
                        // MARK: - Continue / Get Started Button
                        Button {
                            withAnimation(.spring()) {
                                contiune()
                            }
                        } label: {
                            Text(isLastPage ? "Get Started" : "Continue")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.primaryApp)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        
                        // MARK: - Register Text
                        if isLastPage {
                            HStack(spacing: 4) {
                                Text("Don't have an account?")
                                    .foregroundStyle(.gray)
                                
                                Button("Register") {
                                    goToRegister = true
                                }
                                .foregroundStyle(.primaryApp)
                            }
                            .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    .padding(.horizontal, 30)
                    .animation(.easeInOut, value: isLastPage)
                }
                .navigationDestination(isPresented: $goSignIn) {
                    SignInView()
                }
                .navigationDestination(isPresented: $goToRegister) {
                    RegisterView()
                }
            }
        }
    }
    func contiune() {
        if currentPage < 2 {
            currentPage += 1
        } else {
            goSignIn = true
        }
    }
}

struct OnboardingPage: View {
    
    var imageName: String
    
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Image("gridiant")
                .resizable()
//                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaledToFill()

        }
    }
}

#Preview {
    OnboardingView()
}
