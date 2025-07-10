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
        let buttonColors: [Color] = classifier.isRunning ?
        [.red, .orange, .yellow] :
        [
            Color(red: 0.85, green: 0.62, blue: 1.00),
            Color(red: 0.55, green: 0.75, blue: 1.00),
            Color(red: 0.60, green: 1.00, blue: 0.85),
            Color(red: 1.00, green: 0.85, blue: 0.60)
        ]
        ZStack(alignment: .top) {
            CameraView(classifier: classifier)
                .ignoresSafeArea()
                .onChange(of: classifier.isRunning) { _ in
                    // To wywoła updateUIView i zatrzyma/wznowi kamerę.
                }


            Text(classifier.detectedEmotion ?? "Press button to sart detection" .capitalized)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.primary.opacity(0.8))
                .foregroundColor(Color("ButtonBorderColor"))
                .clipShape(Capsule())
                .font(.title3.bold())
                .padding(.top, 50)
            
            VStack {
                Spacer()
                Button {
                    if classifier.isRunning {
                        classifier.stop()
                    } else {
                        classifier.start()
                    }
                } label: {
                    Text(classifier.isRunning ? "Stop" : "Start")
                        .font(.title2)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: buttonColors),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .foregroundColor(Color("ButtonBorderColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("ButtonBorderColor"), lineWidth: 1)
                        )
                        .padding(.bottom, 20)
                }
            }
        }
    }
}
