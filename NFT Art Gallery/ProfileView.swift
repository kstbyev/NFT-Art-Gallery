import SwiftUI

struct ProfileView: View {
    @StateObject private var profileActions = ProfileActions()
    @State private var selectedGalleryFilter = "Created"
    let filters = ["Created", "Collected", "Liked"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header Card
                    ProfileHeaderCard()
                    
                    // Stats Cards
                    StatsGridView()
                    
                    // Gallery Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Gallery")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        // Filter Pills
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(filters, id: \.self) { filter in
                                    FilterPillButton(
                                        title: filter,
                                        isSelected: selectedGalleryFilter == filter
                                    ) {
                                        withAnimation { selectedGalleryFilter = filter }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // NFT Grid
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ],
                            spacing: 16
                        ) {
                            ForEach(NFTDataManager.shared.featuredNFTs) { item in
                                ModernNFTCard(item: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: profileActions.editProfile) {
                            Label("Edit Profile", systemImage: "pencil")
                        }
                        Button(action: profileActions.openSettings) {
                            Label("Settings", systemImage: "gear")
                        }
                        Button(action: profileActions.openHelp) {
                            Label("Help", systemImage: "questionmark.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 22))
                    }
                }
            }
        }
    }
}

struct ProfileHeaderCard: View {
    var body: some View {
        VStack(spacing: 20) {
            // Profile Image
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [.blue.opacity(0.8), .purple.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 90))
                    .foregroundColor(.white)
            }
            
            // Profile Info
            VStack(spacing: 8) {
                Text("Madi Sharipov")
                    .font(.title2)
                    .bold()
                
                Text("@madisharipov")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Digital Artist & NFT Creator")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
            
            // Stats Row
            HStack(spacing: 40) {
                StatItem(value: "256", title: "Following")
                StatItem(value: "1.2K", title: "Followers")
                StatItem(value: "48", title: "Created")
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

struct StatItem: View {
    let value: String
    let title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct StatsGridView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Statistics")
                .font(.title2)
                .bold()
                .padding(.horizontal)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {
                StatCard(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Total Sales",
                    value: "12.8 ETH",
                    iconColor: Color.blue
                )
                StatCard(
                    icon: "star.fill",
                    title: "Avg. Rating",
                    value: "4.8",
                    iconColor: Color.yellow
                )
                StatCard(
                    icon: "creditcard.fill",
                    title: "Revenue",
                    value: "8.5 ETH",
                    iconColor: Color.green
                )
                StatCard(
                    icon: "heart.fill",
                    title: "Total Likes",
                    value: "2.4K",
                    iconColor: Color.red
                )
            }
            .padding(.horizontal)
        }
    }
}

struct FilterPillButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .bold()
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct ModernTrendingView: View {
    let items = NFTDataManager.shared.trendingNFTs
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Trending")
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Button(action: {}) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ],
                spacing: 16
            ) {
                ForEach(items) { item in
                    ModernNFTCard(item: item)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct NFTDetailView: View {
    let item: NFTItem
    @Environment(\.dismiss) private var dismiss
    @State private var isLiked = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Image Section
                ZStack(alignment: .topTrailing) {
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: 400)
                        .clipped()
                    
                    // Like Button
                    Button(action: { withAnimation(.spring()) { isLiked.toggle() }}) {
                        Circle()
                            .fill(Color(.systemBackground))
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .foregroundColor(isLiked ? .red : .gray)
                            )
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                    }
                    .padding()
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    // Title and Price
                    HStack {
                        Text(item.title)
                            .font(.title)
                            .bold()
                        Spacer()
                        Text(item.price)
                            .font(.title2)
                            .bold()
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                    }
                    
                    // Artist Info
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 48, height: 48)
                            .overlay(
                                Text(String(item.artist.prefix(1)))
                                    .font(.title2)
                                    .foregroundColor(.white)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.artist)
                                .font(.headline)
                            Text("Creator")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Follow")
                                .font(.subheadline)
                                .bold()
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                    }
                    
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)
                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    // Stats
                    HStack {
                        StatBox(value: "3.2K", title: "Views")
                        StatBox(value: "295", title: "Likes")
                        StatBox(value: "22", title: "Shares")
                    }
                    
                    // Buy Button
                    Button(action: {}) {
                        HStack {
                            Text("Buy Now")
                                .font(.headline)
                            Spacer()
                            Text(item.price)
                                .font(.headline)
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}

struct StatBox: View {
    let value: String
    let title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
