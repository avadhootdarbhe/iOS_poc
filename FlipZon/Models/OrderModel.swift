import Foundation
import FirebaseFirestore

struct Order: Codable, Identifiable {
    @DocumentID var id: String? = UUID().uuidString
    var userId: String
    var items: [CartItem]
    var total: Double
    var createdAt: Date
}

