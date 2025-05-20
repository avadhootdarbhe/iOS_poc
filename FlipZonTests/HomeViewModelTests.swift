@testable import FlipZon
import XCTest

class HomeViewModelTests: XCTestCase {
    class MockAPIService: APIService {
        var mockResult: Result<[Product], Error>?

        override func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
            if let result = mockResult {
                completion(result)
            }
        }
    }
    
    
    func makeMockProduct(id: Int, title: String = "Mock Product") -> Product {
            return Product(
                id: id,
                title: title,
                price: 99.99,
                description: "Sample description",
                category: Product.Category(
                    id: 1,
                    name: "Mock Category",
                    slug: "mock-category",
                    image: "https://example.com/category.png"
                ),
                images: ["https://example.com/image\(id).png"]
            )
        }


    func testLoadInitialProducts_Success() {
            let mockService = MockAPIService()
            mockService.mockResult = .success([
                makeMockProduct(id: 1, title: "Test Product 1"),
                makeMockProduct(id: 2, title: "Test Product 2")
            ])
            
            let viewModel = HomeViewModel(service: mockService)
            
            let expectation = self.expectation(description: "Load Initial Products")
            viewModel.loadInitialProducts()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertEqual(viewModel.products.count, 2)
                XCTAssertEqual(viewModel.products.first?.title, "Test Product 1")
                XCTAssertFalse(viewModel.isLoading)
                XCTAssertTrue(viewModel.hasMoreData)
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0)
        }
    
    func testLoadInitialProducts_EmptyResult() {
            let mockService = MockAPIService()
            mockService.mockResult = .success([])
            
            let viewModel = HomeViewModel(service: mockService)
            
            let expectation = self.expectation(description: "Empty Products")
            viewModel.loadInitialProducts()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertEqual(viewModel.products.count, 0)
                XCTAssertFalse(viewModel.isLoading)
                XCTAssertFalse(viewModel.hasMoreData)
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0)
        }
    
    func testLoadNextPage_AppendsProducts() {
            let mockService = MockAPIService()
            mockService.mockResult = .success([
                makeMockProduct(id: 3),
                makeMockProduct(id: 4)
            ])
            
            let viewModel = HomeViewModel(service: mockService)
            viewModel.products = [makeMockProduct(id: 1), makeMockProduct(id: 2)]
            viewModel.hasMoreData = true
            
            let expectation = self.expectation(description: "Append Products")
            viewModel.loadNextPage()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertEqual(viewModel.products.count, 4)
                XCTAssertEqual(viewModel.products.last?.id, 4)
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0)
        }
    
    func testLoadInitialProducts_Failure() {
            let mockService = MockAPIService()
            mockService.mockResult = .failure(NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch"]))
            
            let viewModel = HomeViewModel(service: mockService)
            
            let expectation = self.expectation(description: "Handle Error")
            viewModel.loadInitialProducts()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertEqual(viewModel.products.count, 0)
                XCTAssertNotNil(viewModel.errorMessage)
                XCTAssertEqual(viewModel.errorMessage, "Failed to fetch")
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0)
        }
        
}
