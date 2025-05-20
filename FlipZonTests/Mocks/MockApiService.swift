@testable import FlipZon

class MockAPIService: APIService {
    var mockResult: Result<[Product], Error>?

    override func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}
