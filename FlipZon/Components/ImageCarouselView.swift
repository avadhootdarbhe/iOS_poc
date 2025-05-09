// Views/Product/ImageCarouselView.swift

import SwiftUI

struct ImageCarouselView: View {
    let images: [String]

    var body: some View {
        TabView {
            ForEach(images, id: \.self) { imageUrl in
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                        .cornerRadius(12)
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(height: 300)
                        .cornerRadius(12)
                        .overlay(
                            ProgressView()
                        )
                }
            }
        }
        .frame(height: 300)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

#Preview {
    ImageCarouselView(images: ["avadhut", "darbhe"])
}
