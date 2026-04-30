//
//  EditUserView.swift
//  Groceria
//
//  Created by Daddy on 25/04/2026.
//

import SwiftUI

struct EditUserView: View {

    @EnvironmentObject private var router: AppRouter
    @StateObject private var vm = EditUserViewModel()

    var body: some View {
        VStack {

            Image("profilePic")
                .resizable()
                .frame(width: 150, height: 150)

            VStack {

                K.AppTextField(
                    title: "First Name",
                    placeHolder: "Enter your first name",
                    text: $vm.firstNameTextFieldText
                )

                K.AppTextField(
                    title: "Last Name",
                    placeHolder: "Enter your last name",
                    text: $vm.lastNameTextFieldText
                )

                K.AppTextField(
                    title: "Email",
                    placeHolder: "Enter your email",
                    text: $vm.email
                )
            }

            K.ButtonView(imageName: "", text: "Save Changes") {
                vm.saveChanges(router: router)
            }

        }
        .padding()
    }
}

#Preview {
    EditUserView()
        .environmentObject(AppRouter()) 
}
