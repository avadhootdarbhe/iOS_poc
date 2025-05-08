import SwiftUI

struct RootScreen: View {
    @State private var isLoggedIn: Bool? = nil
    
    var body: some View {
        Group {
            if isLoggedIn == nil {
                ProgressView("Loading...")
            } else if isLoggedIn == true {
                HomeScreenView()
                    .navigationBarBackButtonHidden(true)
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
