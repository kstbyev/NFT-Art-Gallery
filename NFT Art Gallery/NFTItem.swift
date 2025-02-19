import Foundation

struct NFTItem: Identifiable, Codable {
    var id = UUID()  // Changed to var with default value
    let title: String
    let artist: String
    let price: String
    let rating: Double
    let imageName: String
    let description: String
    
    init(title: String, artist: String, price: String, rating: Double, imageName: String, description: String = "") {
        self.title = title
        self.artist = artist
        self.price = price
        self.rating = rating
        self.imageName = imageName
        self.description = description
    }
}

// Make NFTItem Hashable based on id
extension NFTItem: Hashable {
    static func == (lhs: NFTItem, rhs: NFTItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}