
import XCTest
@testable import FlipZon

final class SignUpViewModelTests: XCTestCase {
    
    var viewModel: SignUpViewModel!
    var mockSessionManager: SessionManager!
    
    override func setUp() {
        super.setUp()
        viewModel = SignUpViewModel()
        mockSessionManager = SessionManager()
    }
    
    override func tearDown() {
        viewModel = nil
        mockSessionManager = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.name, "")
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertEqual(viewModel.confirmPassword, "")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isSignUpFormValid)
    }
    
    func testFormValidation() {
        viewModel.name = "John Doe"
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        XCTAssertTrue(viewModel.isSignUpFormValid)
        
        viewModel.confirmPassword = "wrongpassword"
        XCTAssertFalse(viewModel.isSignUpFormValid)
        
        viewModel.email = ""
        XCTAssertFalse(viewModel.isSignUpFormValid)
    }
    
    func testSignUpSuccess() {
        // Given
        viewModel.name = "John Doe"
        viewModel.email = "test@example3.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        let expectation = expectation(description: "Sign up should succeed")

        // When
        viewModel.signUp(session: mockSessionManager)

        // Then - wait briefly for async operation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNil(self.viewModel.errorMessage, "The email address is already in use by another account.")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }

    
    func testSignUpFailure() {
        viewModel.name = "John Doe"
        viewModel.email = "invalid@example.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        let expectation = self.expectation(description: "Sign up should fail")
        viewModel.signUp(session: mockSessionManager)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertEqual(self.viewModel.errorMessage, "The email address is already in use by another account.")
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
