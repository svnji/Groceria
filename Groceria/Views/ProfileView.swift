//
//  ProfileView.swift
//  Groceria
//
//  Created by Daddy on 10/03/2026.
//

import SwiftUI

struct ProfileView: View {

    @AppStorage("isLoggedIn") private var isLoggedIn = true
    @AppStorage("firstName") private var firstName = ""
    @AppStorage("lastName") private var lastName = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Profile")
                    .font(.custom("PlusJakartaSans-Bold", size: 24))
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Signed in as")
                        .font(.custom("PlusJakartaSans-Medium", size: 14))
                        .foregroundStyle(.grayScale70)
                    Text("\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces))
                        .font(.custom("PlusJakartaSans-SemiBold", size: 18))
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.secondaryApp)
                .clipShape(RoundedRectangle(cornerRadius: 24))

                Button {
                    AuthManager.shared.signOut()
                    isLoggedIn = false
                } label: {
                    Text("Log out")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundStyle(.error)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .strokeBorder(Color.error, lineWidth: 1.5)
                        )
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileView()
}
