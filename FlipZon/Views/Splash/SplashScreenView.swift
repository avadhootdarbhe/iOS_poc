import SwiftUI

struct SplashScreenView: View {
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.5
    @State private var showRoot: Bool = false
    
    @EnvironmentObject var session: SessionManager

    var body: some View {
      
      return  ZStack {
            if showRoot {
                if session.isLoggedIn {
                    HomeScreenView()
                } else {
                    LoginScreenView()
                }
            } else {
                splashAnimation
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 1.4)) {
                self.scale = 1
                self.opacity = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.showRoot = true
            }
        }
    }

    var splashAnimation: some View {
        VStack {
            Image(systemName: "cart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.white)
            Text("FlipZon")
                .font(.headline)
                .foregroundStyle(.white)
        }
        .scaleEffect(scale)
        .opacity(opacity)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GradientBackground())
    }
}
