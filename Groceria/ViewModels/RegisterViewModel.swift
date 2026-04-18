import Foundation

final class RegisterViewModel: ObservableObject {

    @Published var firstNameTextFieldText = ""
    @Published var lastNameTextFieldText = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    func signUp(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !firstNameTextFieldText.isEmptyOrWhitespace,
              !lastNameTextFieldText.isEmptyOrWhitespace,
              !email.isEmptyOrWhitespace,
              email.isEmail else {
            completion(.failure(HTTPClientError.serverError("Please enter valid name and email.")))
            return
        }
        guard password.isValidPassword, password == confirmPassword else {
            completion(.failure(HTTPClientError.serverError("Password must be at least 8 characters and match confirmation.")))
            return
        }
        Task {
            do {
                _ = try await AuthManager.shared.register(
                    firstName: firstNameTextFieldText.trimmingCharacters(in: .whitespacesAndNewlines),
                    lastName: lastNameTextFieldText.trimmingCharacters(in: .whitespacesAndNewlines),
                    email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                    password: password,
                    passwordConfirmation: confirmPassword
                )
                await MainActor.run { completion(.success(())) }
            } catch {
                await MainActor.run { completion(.failure(error)) }
            }
        }
    }
}
