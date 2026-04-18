import Foundation

final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isRememberMeEnabled = false

    func toggleRememberMe() {
        isRememberMeEnabled.toggle()
    }

    func signIn(completion: @escaping (Bool) -> Void) {
        guard !email.isEmptyOrWhitespace, email.isEmail, password.isValidPassword else {
            completion(false)
            return
        }
        Task {
            do {
                _ = try await AuthManager.shared.login(
                    email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                    password: password
                )
                await MainActor.run { completion(true) }
            } catch {
                await MainActor.run { completion(false) }
            }
        }
    }
}
