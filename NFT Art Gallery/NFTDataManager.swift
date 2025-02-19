import SwiftUI

final class NFTDataManager: ObservableObject {
    static let shared = NFTDataManager()
    
    @Published var featuredNFTs: [NFTItem] = []
    @Published var trendingNFTs: [NFTItem] = []
    @Published var userNFTs: [NFTItem] = []
    @Published var likedNFTs: Set<String> = []
    
    private init() {
        loadInitialData()
        loadUserNFTs()
    }
    
    private func loadInitialData() {
        // Sample data
        featuredNFTs = [
            NFTItem(title: "Digital Dreams", artist: "Madi Sharipov", price: "2.5 ETH", rating: 4.8, imageName: "nft4", description: "A mesmerizing digital artwork"),
            NFTItem(title: "Pixel Paradise", artist: "Adal Nurov", price: "1.8 ETH", rating: 4.5, imageName: "nft2", description: "A pixel art masterpiece"),
            NFTItem(title: "Abstract Thoughts", artist: "Rakhat Sirgebay", price: "3.2 ETH", rating: 4.7, imageName: "nft3", description: "An abstract digital creation")
        ]
        
        trendingNFTs = [
            NFTItem(title: "Future Vision", artist: "Kanat Altair", price: "1.5 ETH", rating: 4.6, imageName: "nft1", description: "A glimpse into the future"),
            NFTItem(title: "Cosmic Wonder", artist: "Serik Amangeldy", price: "2.1 ETH", rating: 4.9, imageName: "nft5", description: "A cosmic exploration piece"),
            NFTItem(title: "Digital Soul", artist: "Conor Nurmagamedov", price: "1.9 ETH", rating: 4.4, imageName: "nft6", description: "Digital art with soul")
        ]
    }
    
    private func loadUserNFTs() {
        if let savedNFTs = UserDefaults.standard.data(forKey: "UserNFTs"),
           let decodedNFTs = try? JSONDecoder().decode([NFTItem].self, from: savedNFTs) {
            userNFTs = decodedNFTs
        }
    }
    
    func addUserNFT(title: String, price: String, description: String, image: UIImage) {
        let imageName = saveImage(image)
        let newNFT = NFTItem(
            title: title,
            artist: "You", // Or get from user profile
            price: price,
            rating: 5.0,
            imageName: imageName,
            description: description
        )
        
        userNFTs.append(newNFT)
        saveUserNFTs()
    }
    
    private func saveUserNFTs() {
        if let encoded = try? JSONEncoder().encode(userNFTs) {
            UserDefaults.standard.set(encoded, forKey: "UserNFTs")
        }
    }
    
    private func saveImage(_ image: UIImage) -> String {
        let imageName = UUID().uuidString
        if let data = image.jpegData(compressionQuality: 0.7) {
            let filename = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: filename)
        }
        return imageName
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func loadImage(named: String) -> UIImage? {
        let filename = getDocumentsDirectory().appendingPathComponent(named)
        return UIImage(contentsOfFile: filename.path)
    }
    
    func toggleLike(for nftID: String) {
        if likedNFTs.contains(nftID) {
            likedNFTs.remove(nftID)
        } else {
            likedNFTs.insert(nftID)
        }
    }
    
    func isLiked(_ nftID: String) -> Bool {
        likedNFTs.contains(nftID)
    }
}
