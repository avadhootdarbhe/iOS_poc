import SwiftUI

struct OrdersScreenView: View {
    @StateObject private var orderManager = CartManager()
    @State private var selectedOrder: Order? = nil
    @State private var showBottomSheet = false

    var body: some View {
        NavigationView {
            VStack {
                List(orderManager.ordeItems) { order in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Order ID: \(order.id ?? "-")")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("Total: $\(order.total, specifier: "%.2f")")
                            .font(.headline)

                        Text("Items: \(order.items.count)")
                            .font(.subheadline)

                        Text("Date: \(order.createdAt.formatted(date: .abbreviated, time: .shortened))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                    .onTapGesture {
                        selectedOrder = order
                        showBottomSheet = true
                        print(order.items.count)
                    }
                }
            }
            .navigationTitle("Your Orders")
            .onAppear {
                orderManager.fetchOrders()
            }
            .overlay(
                Group {
                    if showBottomSheet, let order = selectedOrder {
                        VStack {
                           
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    showBottomSheet = false
                                }
                            OrderDetailsBottomSheet(order: order.items) {
                                
                                showBottomSheet = false
                            }
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut(duration: 0.3), value: showBottomSheet)
                            .zIndex(1)
                        }
                        .edgesIgnoringSafeArea(.all)
                    }
                }
            )
        }
    }
}

struct OrderDetailsBottomSheet: View {
    var order: [CartItem] = []
    var dismissAction: () -> Void
        var body: some View {
            
        VStack {
            HStack {
                Text("Order Items")
                    .font(.headline)
                    .padding()
                Spacer()
                Button(action: dismissAction) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top)
            
            List {
                ForEach(order, id: \.productId) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.image)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        } placeholder: {
                            Color.gray
                                .frame(width: 60, height: 60)
                        }
                        .cornerRadius(8)

                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.body)
                            Text("Qty: \(item.quantity)")
                                .font(.subheadline)
                        }

                        Spacer()
                        Text("$\(Double(item.price) * Double(item.quantity), specifier: "%.2f")")
                    }
                    .padding()
                }
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 8)
        .padding()
        .frame(maxHeight: 500)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
