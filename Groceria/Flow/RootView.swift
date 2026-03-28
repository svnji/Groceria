//
//  RootView.swift
//  Groceria
//
//  Created by Daddy on 27/03/2026.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {

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
    }
}
