//
//  CreateView.swift
//  NFT Art Gallery
//
//  Created by Madi Sharipov on 13.02.2025.
//

import SwiftUI

struct CreateView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var price = ""
    @State private var selectedCategory = "Art"
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    let categories = ["Art", "Music", "Photography", "Virtual Worlds", "Sport"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Image Upload Section
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray6))
                            .frame(height: 240)
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        } else {
                            VStack(spacing: 12) {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 40))
                                    .foregroundColor(.blue)
                                Text("Tap to upload artwork")
                                    .font(.headline)
                            }
                        }
                    }
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    
                    // Form Fields
                    VStack(alignment: .leading, spacing: 20) {
                        InputField(title: "Title", text: $title, placeholder: "Enter NFT title")
                        
                        InputField(title: "Description", text: $description, placeholder: "Describe your NFT", isMultiline: true)
                        
                        InputField(title: "Price (ETH)", text: $price, placeholder: "0.00", keyboardType: .decimalPad)
                        
                        // Category Picker
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Category")
                                .font(.headline)
                            
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    // Create Button
                    Button(action: createNFT) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("Create NFT")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.headline)
                    }
                    .padding(.top, 12)
                }
                .padding()
            }
            .navigationTitle("Create NFT")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
    
    func createNFT() {
        // Implement NFT creation logic
        print("Creating NFT...")
    }
}

struct InputField: View {
    let title: String
    @Binding var text: String
    var placeholder: String
    var isMultiline: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            if isMultiline {
                TextEditor(text: $text)
                    .frame(height: 100)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
} 
