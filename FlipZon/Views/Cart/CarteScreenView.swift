import SwiftUI

struct CartScreenView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        List {
            ForEach(cartManager.items) { item in
                HStack {
                    AsyncImage(url: URL(string: item.image)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)

                    VStack(alignment: .leading) {
                        Text(item.title)
                        Text("Qty: \(item.quantity)")
                    }

                    Spacer()
                    Text("$\(item.price * item.quantity)")
                    
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let item = cartManager.items[index]
                    cartManager.removeItem(cartItem: item)
                }
            }
            
        }
        .navigationTitle("Your Cart")
        .onAppear {
            cartManager.fetchCart()
        }
    }
}
