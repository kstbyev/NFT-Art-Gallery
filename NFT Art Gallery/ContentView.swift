//
//  ContentView.swift
//  NFT Art Gallery
//
//  Created by Madi Sharipov on 12.02.2025.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = 0
    @EnvironmentObject var dataManager: NFTDataManager
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Hero Section
                        HeroSection()
                        
                        // Categories
                        ModernCategoryView()
                        
                        // Featured NFTs
                        ModernFeaturedView()
                        
                        // Trending Grid
                        ModernTrendingView()
                    }
                    .padding(.bottom, 90)
                }
                .navigationTitle("Discover")
                .navigationBarTitleDisplayMode(.large)
            }
            .tabItem {
                Label("Discover", systemImage: "sparkles")
            }
            .tag(0)
            
            CreateView()
                .tabItem {
                    Label("Create", systemImage: "plus.circle.fill")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag(2)
        }
    }
}

struct HeroSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Featured Artist")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(1...3, id: \.self) { _ in
                        ArtistFeatureCard()
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ArtistFeatureCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Artist Image
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 60, height: 60)
                
                Image(systemName: "person.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Danial Kaireken")
                    .font(.headline)
                Text("Digital Artist")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Label("2.5K", systemImage: "heart.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                
                Spacer()
                
                Button(action: {}) {
                    Text("Follow")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
        }
        .padding(16)
        .frame(width: 200)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct ModernCategoryView: View {
    let categories = ["Trending", "Art", "Music", "Virtual", "Sport"]
    @State private var selectedCategory = "Trending"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Browse Categories")
                .font(.title3)
                .bold()
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: { selectedCategory = category }) {
                            VStack(spacing: 8) {
                                Circle()
                                    .fill(selectedCategory == category ? Color.blue : Color.gray.opacity(0.1))
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image(systemName: categoryIcon(for: category))
                                            .font(.system(size: 24))
                                            .foregroundColor(selectedCategory == category ? .white : .gray)
                                    )
                                
                                Text(category)
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(selectedCategory == category ? .primary : .secondary)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    func categoryIcon(for category: String) -> String {
        switch category {
        case "Trending": return "flame"
        case "Art": return "paintbrush"
        case "Music": return "music.note"
        case "Virtual": return "vr"
        case "Sport": return "sportscourt"
        default: return "circle"
        }
    }
}

struct ModernFeaturedView: View {
    let items = NFTDataManager.shared.featuredNFTs
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Featured")
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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(items) { item in
                        ModernNFTCard(item: item)
                            .frame(width: 240)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NFTDataManager.shared)
}


