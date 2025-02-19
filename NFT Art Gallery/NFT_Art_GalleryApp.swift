//
//  NFT_Art_GalleryApp.swift
//  NFT Art Gallery
//
//  Created by Madi Sharipov on 12.02.2025.
//

import SwiftUI

@main
struct NFT_Art_GalleryApp: App {
    @StateObject private var dataManager = NFTDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
        }
    }
}
