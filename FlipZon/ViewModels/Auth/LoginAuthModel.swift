import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    var isEmailValid: Bool {
        Validators.isValidEmail(email)
    }

    var isPasswordValid: Bool {
        password.count >= 6
    }

    var isFormValid: Bool {
        isEmailValid && isPasswordValid
    }

    func login(completion: @escaping (Bool) -> Void) {
        isLoading = true
        errorMessage = nil

        FirebaseManager.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    completion(true)
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    
    func login(session: SessionManager) {
        isLoading = true
        errorMessage = nil
        FirebaseManager.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    session.logIn()
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func logout() {
        isLoading = true
        errorMessage = nil
        do {
            try FirebaseManager.shared.signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
