import SwiftUI


struct ProductDetailScreenView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ImageCarouselView(images: product.images)
                Text(product.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text("$\(product.price)")
                    .font(.title2)
                    .foregroundColor(.green)

                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)

                Spacer()
                Button(action: {
                                    // Add to cart action
                    }) {
                        HStack {
                            Spacer()
                            Text("Add to Cart")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                    }
                }
                .padding()
            }
                .navigationTitle("Details")
                .navigationBarTitleDisplayMode(.inline)
        
        }
    }


