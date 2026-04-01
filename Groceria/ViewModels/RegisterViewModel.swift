import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    func signUp(completion: @escaping (Bool) -> Void) {
        AuthManager.shared.signUp(
            email: email,
            password: password
        ) { result in
            switch result {
            case .success(let user):
                print("User created:", user.uid)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
