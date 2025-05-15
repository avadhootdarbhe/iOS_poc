//
//  SplashScreenView.swift
//  FlipZon
//
//  Created by Avadhoot Prasad DARBHE on 07/05/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.5
    @State private var showRoot: Bool = false
    @State private var isLoggedIn: Bool? = nil
    
    @EnvironmentObject var session: SessionManager
    var body: some View {
        if showRoot {
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
            
        } else {
            VStack {
                Image(systemName: "cart.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
                Text("FlipZon")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .foregroundColor(.white)
            }
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.linear(duration: 1.4)) {
                    self.scale = 1
                    self.opacity = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showRoot = true
                }
                
                let user = FirebaseManager.shared.getCurrentUser()
                isLoggedIn = (user != nil)
            
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GradientBackground())
            
        }
       
    }
}

#Preview {
    SplashScreenView()
}
