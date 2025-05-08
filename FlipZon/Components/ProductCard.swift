import SwiftUI

struct ProductCard: View {
    var product: Product
    var body: some View {
        VStack {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(maxHeight: 150)
            Text(product.name)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(1)
            Text("$\(String(format: "%.2f", product.price))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    ProductCard(
        product: .init(name: "Test Product", price: 100, image: "iphone")
    )
}
