import XCTest
import FirebaseAuth
@testable import FlipZon

final class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mockSessionManager: SessionManager!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
        mockSessionManager = SessionManager()
    }
    
    override func tearDown() {
        viewModel = nil
        mockSessionManager = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isFormValid)
    }
    
//    func testFormValidation() {
//        viewModel.email = "test@example.com"
//        viewModel.password = "password123"
//        XCTAssertTrue(viewModel.isFormValid)
//        
//        viewModel.email = ""
//        XCTAssertFalse(viewModel.isFormValid)
//        
//        viewModel.email = "test@example.com"
//        viewModel.password = ""
//        XCTAssertFalse(viewModel.isFormValid)
//    }
//    
//    func testLoginSuccess() {
//        viewModel.email = "test@gmail.com"
//        viewModel.password = "123456"
//        
//        let expectation = self.expectation(description: "Login should succeed")
//        viewModel.login(session: mockSessionManager)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            XCTAssertNil(self.viewModel.errorMessage)
//            XCTAssertFalse(self.viewModel.isLoading)
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 2, handler: nil)
//    }
//    
//    func testLoginFailure() {
//        viewModel.email = "invalid@example.com"
//        viewModel.password = "wrongpassword"
//        
//        let expectation = self.expectation(description: "Login should fail")
//        viewModel.login(session: mockSessionManager)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            XCTAssertNotNil(self.viewModel.errorMessage)
//            XCTAssertEqual(self.viewModel.errorMessage, "The supplied auth credential is malformed or has expired.")
//            XCTAssertFalse(self.viewModel.isLoading)
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 2, handler: nil)
//    }
    
    func testLoginSuccess() {
            let mockService = MockAuthService()
            mockService.shouldLoginSucceed = true
            let viewModel = LoginViewModel(authService: mockService)

            let expectation = XCTestExpectation(description: "Login succeeds")

            viewModel.email = "test@example.com"
            viewModel.password = "password123"

            viewModel.login { success in
                XCTAssertTrue(success)
                XCTAssertNil(viewModel.errorMessage)
                XCTAssertFalse(viewModel.isLoading)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 1.0)
        }
}
