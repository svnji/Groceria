import Foundation

final class OTPViewModel: ObservableObject {
    @Published var showOverlay = false
    @Published var enterValue = Array(repeating: "", count: 4)

    func handleOTPChange(at index: Int, newValue: String) -> Int? {
        if newValue.count > 1 {
            enterValue[index] = String(newValue.prefix(1))
        }

        if !newValue.isEmpty {
            if index < 3 {
                return index + 1
            }
            verifyOTP()
            return nil
        }

        if index > 0 {
            return index - 1
        }
        return index
    }

    private func verifyOTP() {
        let otp = enterValue.joined()
        print("Entered OTP:", otp)
    }
}
