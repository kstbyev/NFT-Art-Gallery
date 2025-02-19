import SwiftUI
import Combine

class ProfileActions: ObservableObject {
    @Published var isEditing = false
    @Published var showingWallet = false
    @Published var showingNotifications = false
    @Published var showingSettings = false
    @Published var showingHelp = false
    
    func editProfile() {
        isEditing.toggle()
        print("Editing profile...")
    }
    
    func openWallet() {
        showingWallet.toggle()
        print("Opening wallet...")
    }
    
    func openNotifications() {
        showingNotifications.toggle()
        print("Opening notifications...")
    }
    
    func openSettings() {
        showingSettings.toggle()
        print("Opening settings...")
    }
    
    func openHelp() {
        showingHelp.toggle()
        print("Opening help...")
    }
} 