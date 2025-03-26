//
//  ImageLoader.swift
//  EmotionDetectionApp
//
//  Created by Mikołaj Myśliński on 25/03/2025.
//

import SwiftUI
import CoreImage

class ImageLoader: ObservableObject {
    @Published var currentUIImage: UIImage?
    var currentCIImage: CIImage? {
        guard let image = currentUIImage else { return nil }
        return CIImage(image: image)
    }
    
    private var images: [String] = [
        "HAPPY_SHREK",
        "WEIRD_SHREK",
        "CONFIUSED_SHREK",
        "CONCUSION_SHREK",
        "SCREAM_SHREK",
        "ANGRY",
        "HAPPY",
        "NEUTRAL"
    ] // Nazwy obrazów z Assets
    
    private var currentIndex = 0
    
    func loadImages() {
        // Załaduj pierwszy obraz z Asset Catalog
        images = images.filter { UIImage(named: $0) != nil }
        
        if let firstImageName = images.first {
            currentUIImage = UIImage(named: firstImageName)
        }
    }
    
    func nextImage() {
        guard !images.isEmpty else { return }
        currentIndex = (currentIndex + 1) % images.count
        currentUIImage = UIImage(named: images[currentIndex])
    }
    
    func previousImage() {
        guard !images.isEmpty else { return }
        currentIndex = (currentIndex - 1 + images.count) % images.count
        currentUIImage = UIImage(named: images[currentIndex])
    }
}
