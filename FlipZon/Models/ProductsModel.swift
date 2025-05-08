
import Foundation

struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let images: [String]
    
    struct Category: Codable, Equatable {
        let id: Int
        let name: String
        let slug: String
        let image: String
    }
}
