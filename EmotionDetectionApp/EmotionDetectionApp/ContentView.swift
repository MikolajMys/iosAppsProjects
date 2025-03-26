//
//  ContentView.swift
//  EmotionDetectionApp
//
//  Created by Mikołaj Myśliński on 25/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var imageLoader = ImageLoader()
    @StateObject private var classifier = EmotionClassifier()
    
    var body: some View {
        VStack {
            if let image = imageLoader.currentUIImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Text("Brak obrazu")
                    .frame(height: 300)
            }
            
            Text("Emocja: \(classifier.detectedEmotion ?? "N/A")")
                .font(.headline)
                .padding()
            
            HStack {
                Button("Poprzednie") { imageLoader.previousImage() }
                Button("Skanuj") {
                    if let ciImage = imageLoader.currentCIImage {
                        classifier.classify(image: ciImage)
                    } else {
                        classifier.detectedEmotion = "Nie można przeanalizować"
                    }
                }
                Button("Następne") { imageLoader.nextImage() }
            }
            .padding()
        }
        .onAppear {
            imageLoader.loadImages()
        }
    }
}
