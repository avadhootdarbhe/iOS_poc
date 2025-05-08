import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var price: Double
    var image: String
}
