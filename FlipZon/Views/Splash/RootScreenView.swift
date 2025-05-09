import SwiftUI

struct RootScreen: View {
    @State private var isLoggedIn: Bool? = nil
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        Group {
            if isLoggedIn == nil {
                ProgressView("Loading...")
            } else if isLoggedIn == true {
                if session.isLoggedIn {
                    HomeScreenView()
                } else {
                    LoginScreenView()
                }
            } else {
                LoginScreenView()
            }
        }
        .onAppear {
            let user = FirebaseManager.shared.getCurrentUser()
            isLoggedIn = (user != nil)
        }
    }
}
