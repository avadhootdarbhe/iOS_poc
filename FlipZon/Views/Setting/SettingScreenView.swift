import SwiftUI

struct SettingScreenView: View {
    @State private var showLogoutConfirm = false
    @EnvironmentObject var session: SessionManager
    @StateObject private var viewModel = LoginViewModel()
    var body: some View {
        Form {
            Section(header: Text("Account")) {
                NavigationLink("Profile", destination: Text("Profile Page"))
                NavigationLink(destination: OrdersScreenView()) {
                    Label("My Orders", systemImage: "bag")
                }
            }
            Section(header: Text("App")) {
                            NavigationLink("About", destination: Text("About App"))
                            NavigationLink("Terms & Conditions", destination: Text("T&C Page"))
                        }
            Section {
                            Button(role: .destructive) {
                                showLogoutConfirm = true
                            } label: {
                                Text("Log Out")
                            }
                        }
            
        }
        .navigationTitle("Settings")
        .alert("Are you sure you want to log out?", isPresented: $showLogoutConfirm) {
            
            Button("Cancel", role: .cancel) {}
            Button("Log Out", role: .destructive) {
                session.logOut()
            }
        }
    }
}

#Preview {
    SettingScreenView()
}
