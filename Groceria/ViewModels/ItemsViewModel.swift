import Foundation

final class ItemsViewModel: ObservableObject {
    @Published var user: GetHubUserModel?

    func loadUser() async {
        do {
            user = try await getUser()
        } catch GHError.invalidUrl {
            print("invalidUrl")
        } catch GHError.invalidData {
            print("invalidData")
        } catch GHError.invalidResponse {
            print("invalidResponse")
        } catch {
            print("unexpected error")
        }
    }

    private func getUser() async throws -> GetHubUserModel {
        let endpoint = "https://api.github.com/users/svnji"

        guard let url = URL(string: endpoint) else {
            throw GHError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GetHubUserModel.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}
