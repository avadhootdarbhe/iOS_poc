import FirebaseAuth
@testable import FlipZon

class MockAuthService: AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<FlipZon.SimpleUser, any Error>) -> Void) {
        if shouldLoginSucceed {
            let mockUser = SimpleUser(uid: "testUID", email: "test@example.com")
            completion(.success(mockUser))
        } else {
            completion(.failure(NSError(domain: "Auth", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock login failed"])))
        }
    }
    
    var shouldLoginSucceed = true

}
