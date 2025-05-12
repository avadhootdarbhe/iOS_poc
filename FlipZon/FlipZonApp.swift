//
//  FlipZonApp.swift
//  FlipZon
//
//  Created by Avadhoot Prasad DARBHE on 07/05/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct FlipZonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var session = SessionManager()
    @StateObject var cartManager = CartManager()
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(session)
                .environmentObject(cartManager)
        }
    }
}
