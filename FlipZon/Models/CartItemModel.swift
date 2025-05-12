
import Foundation
import FirebaseFirestore

struct CartItem: Identifiable, Codable, Equatable {
    @DocumentID var id: String? 
    let productId: Int
    let title: String
    let price: Int
    let quantity: Int
    let image: String
}
