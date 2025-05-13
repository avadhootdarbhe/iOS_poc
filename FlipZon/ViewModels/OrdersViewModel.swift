import FirebaseFirestore
import FirebaseAuth

class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var isLoading = false

    func fetchOrders() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user is logged in.")
            return
        }

        // Set loading state to true while fetching
        isLoading = true

        // Firestore query to fetch orders for the current user
        Firestore.firestore().collection("orders")
            .addSnapshotListener { snapshot, error in
                DispatchQueue.main.async {
                    self.isLoading = false
                }

                // Error handling
                if let error = error {
                    print("Failed to fetch orders: \(error.localizedDescription)")
                    return
                }

                // Mapping snapshot to Order model
                self.orders = snapshot?.documents.compactMap {
                    try? $0.data(as: Order.self)  // Decoding Order from Firestore document
                } ?? []
            }
    }
}
