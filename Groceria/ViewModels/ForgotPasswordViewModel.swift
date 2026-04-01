import Foundation

final class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""

    func continueFlow(onValid: () -> Void) {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        onValid()
    }
}
