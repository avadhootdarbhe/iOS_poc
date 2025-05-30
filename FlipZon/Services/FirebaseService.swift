import Foundation
import FirebaseAuth


class FirebaseManager:ObservableObject, AuthServiceProtocol {
    
    static let shared = FirebaseManager()
    
    private init() {}
    @Published var isLoggedIn: Bool = Auth.auth().currentUser != nil
    
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }

    
   
    func login(email: String, password: String, completion: @escaping (Result<SimpleUser, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                let simpleUser = SimpleUser(uid: user.uid, email: user.email ?? "")
                completion(.success(simpleUser))
            }
        }
    }


    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    
}
