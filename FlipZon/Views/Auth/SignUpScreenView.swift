
import SwiftUI

struct SignUpScreenView: View {
    @StateObject private var authVM = SignUpViewModel()
    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack( spacing: 20) {
                HStack {
                    Text("Please Create Account ")
                        .font(.title3)
                    Spacer()
                }
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100)
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.white)
                }
                Spacer().frame(height: 10)
                TextField("Name", text: $authVM.name)
                    .keyboardType(.alphabet)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    
                TextField("Email", text: $authVM.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                SecureField("Password", text: $authVM.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                SecureField(" Confirm Password", text: $authVM.confirmPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                
                if let error = authVM.errorMessage {
                                    Text(error)
                                        .foregroundColor(.red)
                                        .font(.subheadline)
                                }
                
                Button(action: {
                    authVM.signUp { success in
                                        if success {
                                            session.isLoggedIn = true
                                        }
                                    }
                                }) {
                                    Text(authVM.isLoading ? "Signing up..." : "Sign Up")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(authVM.isSignUpFormValid ? Color.blue : Color.gray)
                                        .cornerRadius(8)
                                }
                                .disabled(!authVM.isSignUpFormValid || authVM.isLoading)
                Button("Already have an account? Login") {
                                    dismiss()
                                }
                                .font(.footnote)
            
            }
            .frame(maxWidth: screenWidth, maxHeight: screenHeight, alignment: .top)
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Sign Up")
        }
    }


#Preview {
    NavigationStack {
        SignUpScreenView()
    }
}
