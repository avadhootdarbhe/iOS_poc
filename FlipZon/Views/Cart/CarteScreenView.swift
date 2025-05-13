import SwiftUI

struct CartScreenView: View {
    @EnvironmentObject var cartManager: CartManager

    var totalAmount: Double {
        cartManager.items.reduce(0) { $0 + (Double($1.price) * Double($1.quantity)) }
    }

    var body: some View {
        VStack {
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
                        Text("$\(Double(item.price) * Double(item.quantity), specifier: "%.2f")")
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let item = cartManager.items[index]
                        cartManager.removeItem(cartItem: item)
                    }
                }
            }

            VStack(spacing: 12) {
                // Total Bill
                HStack {
                    Text("Total:")
                        .font(.headline)
                    Spacer()
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .font(.headline)
                }
                .padding(.horizontal)

                // Place Order Button
                Button(action: {
                    cartManager.placeOrder { success in
                           if success {
                               print("Order placed!")
                           } else {
                               print("Failed to place order.")
                           }
                       }
                }) {
                    Text("Place Order")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(cartManager.items.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(cartManager.items.isEmpty)
            }
            .padding(.vertical)
        }
        .navigationTitle("Your Cart")
        .onAppear {
            cartManager.fetchCart()
        }
    }
}
