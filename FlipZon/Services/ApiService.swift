import Foundation

class APIService {
    static let shared = APIService() // Singleton

    func fetchProducts(offset: Int = 0, limit: Int = 10) async throws -> [Product] {
        let urlString = "https://api.escuelajs.co/api/v1/products?offset=\(offset)&limit=\(limit)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode([Product].self, from: data)
        return products
    }
}
