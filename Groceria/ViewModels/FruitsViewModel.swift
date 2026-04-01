import Foundation

final class FruitsViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedCategory = "All Fruits"

    let categories = ["All Fruits", "Apple", "Banana"]
    let fruits: [(String, String, String, String)] = {
        var array: [(String, String, String, String)] = []
        for _ in 0..<10 {
            array.append(("Honeycrisp Apple", "Apple", "1.5K Sold", "$12.00 /Kg"))
            array.append(("Cavendish Banana", "Banana", "1.5K Sold", "$20.00 /Kg"))
        }
        return array
    }()

    var filteredFruits: [(String, String, String, String)] {
        fruits.filter { fruit in
            (selectedCategory == "All Fruits" || fruit.1 == selectedCategory) &&
            (searchText.isEmpty || fruit.0.localizedCaseInsensitiveContains(searchText))
        }
    }

    func selectCategory(_ category: String) {
        selectedCategory = category
    }
}
