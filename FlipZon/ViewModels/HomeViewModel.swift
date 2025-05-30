import Foundation

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var hasMoreData = true
    @Published var errorMessage: String?

    private let service: APIService
    private let limit = 10
    private var currentOffset = 0

    init(service: APIService = APIService.shared) {
        self.service = service
    }

    func loadInitialProducts() {
        products = []
        currentOffset = 0
        hasMoreData = true
        loadNextPage()
    }

    func loadNextPage() {
        guard !isLoading && hasMoreData else { return }
        isLoading = true

        service.fetchProducts(offset: currentOffset, limit: limit) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let newProducts):
                    self.products.append(contentsOf: newProducts)
                    self.currentOffset += newProducts.count
                    self.hasMoreData = !newProducts.isEmpty
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
