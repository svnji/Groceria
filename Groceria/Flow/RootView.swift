//
//  RootView.swift
//  Groceria
//
//  Created by Daddy on 27/03/2026.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {

    // REVIEW:
    // `HomeView` expects `@EnvironmentObject private var vm: HomeViewModel`.
    // So RootView must create the VM once and inject it via `.environmentObject(...)`.
    @StateObject private var vm = HomeViewModel()
    
    @AppStorage("hasOnboarded") private var hasOnboarded = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            if !hasOnboarded {
                OnboardingView()
            } else if !isLoggedIn {
                SignInView()
            } else {
                CustomTabBar()
            }
        }
        .animation(.easeInOut, value: isLoggedIn)
        // REVIEW: make the VM available to child views.
        .environmentObject(vm)
    }
}
