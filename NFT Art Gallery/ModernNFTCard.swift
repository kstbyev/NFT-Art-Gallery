//
//  ModernNFTCard.swift
//  NFT Art Gallery
//
//  Created by Madi Sharipov on 13.02.2025.
//

import SwiftUI

struct ModernNFTCard: View {
    let item: NFTItem
    @State private var isLiked = false
    @State private var showingDetail = false
    
    var body: some View {
        Button(action: { showingDetail.toggle() }) {
            VStack(spacing: 0) {
                // Image Container
                ZStack(alignment: .topTrailing) {
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 160)
                        .clipped()
                    
                    // Like Button
                    Button(action: {
                        withAnimation(.spring()) {
                            isLiked.toggle()
                        }
                    }) {
                        Circle()
                            .fill(Color(.systemBackground))
                            .frame(width: 32, height: 32)
                            .overlay(
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .font(.system(size: 14))
                                    .foregroundColor(isLiked ? .red : .gray)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .padding(8)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.title)
                        .font(.callout)
                        .bold()
                        .lineLimit(1)
                    
                    HStack {
                        // Artist
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 20, height: 20)
                                .overlay(
                                    Text(String(item.artist.prefix(1)))
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                )
                            
                            Text(item.artist)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        // Price
                        Text(item.price)
                            .font(.caption)
                            .bold()
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }
                }
                .padding(12)
            }
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingDetail) {
            NavigationView {
                NFTDetailView(item: item)
                    .navigationBarItems(trailing: Button("Done") {
                        showingDetail = false
                    })
            }
        }
    }
}
