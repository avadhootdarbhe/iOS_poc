// AppState/SessionManager.swift

import SwiftUI
import FirebaseAuth

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = Auth.auth().currentUser != nil

    func logOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Logout error:", error.localizedDescription)
        }
    }

    func logIn() {
        isLoggedIn = true
    }
}
