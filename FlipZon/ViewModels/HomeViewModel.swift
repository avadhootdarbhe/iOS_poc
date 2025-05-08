import Foundation

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    init() {
        fetchProducts()
    }

    func fetchProducts() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let fetchedProducts = try await APIService.shared.fetchProducts()
                DispatchQueue.main.async {
                    self.products = fetchedProducts
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
