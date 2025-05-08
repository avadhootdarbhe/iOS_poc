import Foundation

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    init() {
        // Mock data
        self.products = [
            Product(name: "T-Shirt", price: 19.99, image: "product"),
            Product(name: "Jeans", price: 39.99, image: "product"),
            Product(name: "Sneakers", price: 59.99, image: "product"),
            Product(name: "Watch", price: 99.99, image: "product"),
            Product(name: "Watch", price: 99.99, image: "product"),
            Product(name: "Watch", price: 99.99, image: "product"),
            Product(name: "Watch", price: 99.99, image: "product"),
            Product(name: "Watch", price: 99.99, image: "product"),
            
            // Add more mock products as needed
        ]
    }
}
