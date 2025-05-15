import SwiftUI

struct LoginScreenView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var session: SessionManager
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer().frame(height: 10)
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100)
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.white)
                }
                Spacer().frame(height: 10)
                // Email Field
                HStack{
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)

                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)
                .frame(height: 50)  // Consistent height
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)


                // Password Field
                HStack{
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                        .font(.headline)

                    SecureField("Password", text: $viewModel.password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)
                .frame(height: 50)  // Same height as email
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)


                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                }
                
                Button(action: {
                    viewModel.login(session: session)
                }) {
                    Text(viewModel.isLoading ? "Loading..." : "Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!viewModel.isFormValid || viewModel.isLoading)
                
                NavigationLink(destination: SignUpScreenView()) {
                                    Text("Don't have an account? Sign Up")
                                        .font(.footnote)
                                }
                              

            
            }
            .frame(maxWidth: screenWidth, maxHeight: screenHeight, alignment: .top)
            .padding()
            .navigationBarTitle("Welcome Back!")
            
            
        }
    }
}

#Preview {
    LoginScreenView()
}
