import Foundation

final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isRememberMeEnabled = false

    func toggleRememberMe() {
        isRememberMeEnabled.toggle()
    }

    func signIn(completion: @escaping (Bool) -> Void) {
        AuthManager.shared.signIn(
            email: email,
            password: password
        ) { result in
            switch result {
            case .success(let user):
                print("Logged in:", user.uid)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
