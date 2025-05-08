import Foundation
import FirebaseAuth

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    // Sign Up
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }    }

    
    // Login
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }

    
    // Sign Out
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Get current user
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
}
