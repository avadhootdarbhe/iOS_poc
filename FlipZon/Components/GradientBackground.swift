
import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}
