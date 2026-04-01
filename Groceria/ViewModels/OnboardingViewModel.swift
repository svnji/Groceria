import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0

    var isLastPage: Bool {
        currentPage == 2
    }

    var subTitle: String {
        switch currentPage {
        case 0:
            return "Convenience for Your Everyday Essentials"
        case 1:
            return "Effortless Access to Daily Necessities"
        case 2:
            return "Daily Grocery Needs, Just a Tap Away"
        default:
            return "Convenience for Your Everyday Essentials"
        }
    }

    func goToNextPage() {
        if currentPage < 2 {
            currentPage += 1
        }
    }
}
