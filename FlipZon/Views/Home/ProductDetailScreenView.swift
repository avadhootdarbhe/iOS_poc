import SwiftUI


struct ProductDetailScreenView: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    
   
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
                    cartManager.addToCart(product: product)
                }) {
                    HStack {
                        Spacer()
                        
                        if cartManager.isAddingToCart {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Add to Cart")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(cartManager.isAddingToCart ? Color.gray : Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                }
                .disabled(cartManager.isAddingToCart) // prevent taps during loading
                .padding()

            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            
        }
    }
    
}
