//
//  ContentView.swift
//  EmotionDetectionApp
//
//  Created by Mikołaj Myśliński on 25/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var classifier = EmotionClassifier()
    
    var body: some View {
        ZStack(alignment: .top) {
            CameraView(classifier: classifier)
                .ignoresSafeArea()

            if let emotion = classifier.detectedEmotion {
                Text(emotion.capitalized)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .font(.title3.bold())
                    .padding(.top, 50)
            }
        }
    }
}
