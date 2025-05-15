import Foundation
import FirebaseAuth
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var name: String = ""
    @Published var confirmPassword: String = ""
    
    var isNameValid: Bool {
        name.count >= 2
    }
    
    var isConfirmPasswordValid: Bool {
        password == confirmPassword && !confirmPassword.isEmpty
    }
    
    var isEmailValid: Bool {
        Validators.isValidEmail(email)
    }
    
    var isPasswordValid: Bool {
        password.count >= 6
    }
    
    var isFormValid: Bool {
        isEmailValid && isPasswordValid
    }
    
    var isSignUpFormValid: Bool {
        isNameValid && isEmailValid && isPasswordValid && isConfirmPasswordValid
    }
    
    func signUp(session: SessionManager) {
        isLoading = true
        errorMessage = nil
        
        FirebaseManager.shared.signUp(email: email, password: password) { result in
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
}
