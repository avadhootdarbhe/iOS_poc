
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var ordeItems: [Order] = []
    @Published var isAddingToCart = false
    private var db = Firestore.firestore()
    
    func userCartRef() -> CollectionReference? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return db.collection("users").document(uid).collection("cart")
    }
    
    func userOrdersRef() -> CollectionReference? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return Firestore.firestore().collection("users").document(uid).collection("orders")
    }

    
    func fetchCart() {
        userCartRef()?.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.items = documents.compactMap { try? $0.data(as: CartItem.self) }
        }
    }
    
    func addToCart(product: Product, quantity: Int = 1, completion: (() -> Void)? = nil) {
        guard let cartRef = userCartRef() else {
            DispatchQueue.main.async {
                self.isAddingToCart = false
                completion?()
            }
            return
        }

        DispatchQueue.main.async {
            self.isAddingToCart = true
        }

        if let existing = items.first(where: { $0.productId == product.id }) {
            let newQty = existing.quantity + quantity
            cartRef.document(existing.id!).setData([
                "productId": product.id,
                "title": product.title,
                "price": product.price,
                "quantity": newQty,
                "image": product.images.first ?? ""
            ]) { error in
                DispatchQueue.main.async {
                    self.isAddingToCart = false
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                    }
                    completion?()
                }
            }

        } else {
            cartRef.addDocument(data: [
                "productId": product.id,
                "title": product.title,
                "price": product.price,
                "quantity": quantity,
                "image": product.images.first ?? ""
            ]) { error in
                DispatchQueue.main.async {
                    self.isAddingToCart = false
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                    }
                    completion?()
                }
            }
        }
    }


    func removeItem(cartItem: CartItem) {
        guard let id = cartItem.id, let cartRef = userCartRef() else { return }
        cartRef.document(id).delete()
    }
    
    func clearCart() {
        guard let cartRef = userCartRef() else { return }
        for item in items {
            if let id = item.id {
                cartRef.document(id).delete()
            }
        }
    }
    
    func placeOrder(completion: @escaping (Bool) -> Void) {
        guard let orderRef = userOrdersRef(), !items.isEmpty else {
            completion(false)
            return
        }

        let total = items.reduce(0) { $0 + (Double($1.price) * Double($1.quantity)) }
        let order = Order(
            userId: Auth.auth().currentUser?.uid ?? "",
            items: items,
            total: total,
            createdAt: Date()
        )

        do {
            try orderRef.addDocument(from: order) { error in
                if let error = error {
                    print("Failed to place order: \(error.localizedDescription)")
                    completion(false)
                } else {
                   
                    self.clearCart()
                    completion(true)
                }
            }
        } catch {
            print("Encoding error: \(error)")
            completion(false)
        }
    }
    
    func fetchOrders() {
        userOrdersRef()?.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.ordeItems = documents.compactMap { try? $0.data(as: Order.self) }
        }
    }

}
