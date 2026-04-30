//
//  RootView.swift
//  Groceria
//
//  Created by Daddy on 27/03/2026.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var vm = HomeViewModel()
    @StateObject private var cart = CartManager()
    @StateObject private var router = AppRouter() 
    
    @AppStorage("hasOnboarded") private var hasOnboarded = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                if !hasOnboarded {
                    OnboardingView()
                } else if !isLoggedIn {
                    SignInView()
                } else {
                    CustomTabBar()
                }
            }
            .navigationDestination(for: AppRouter.Route.self) { route in
                switch route {
                case .login:
                    SignInView()
                case .register:
                    RegisterView()
                case .home:
                    CustomTabBar()
                case .user:
                    EditUserView()
                case .newPassword:
                    CreateNewPassword()
                }
            }
        }
        .animation(.easeInOut, value: isLoggedIn)
        .environmentObject(vm)
        .environmentObject(cart)
        .environmentObject(router)
    }
}
