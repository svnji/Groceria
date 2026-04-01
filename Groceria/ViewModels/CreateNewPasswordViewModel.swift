import Foundation

final class CreateNewPasswordViewModel: ObservableObject {
    @Published var newPasswordText = ""
    @Published var confirmPasswordText = ""

    var canContinue: Bool {
        !newPasswordText.isEmpty && newPasswordText == confirmPasswordText
    }
}
