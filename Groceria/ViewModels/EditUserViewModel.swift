//
//  EditUserViewModel.swift
//  Groceria
//
//  Created by Daddy on 25/04/2026.
//

import Foundation
import SwiftUI

class EditUserViewModel: ObservableObject {
    @Published var firstNameTextFieldText = ""
    @Published var lastNameTextFieldText = ""
    @Published var email = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""

    init() {
        firstNameTextFieldText = firstName
        lastNameTextFieldText = lastName
    }

    func saveChanges(router: AppRouter) {
        firstName = firstNameTextFieldText
        lastName = lastNameTextFieldText
        router.popToRoot()
    }
}
