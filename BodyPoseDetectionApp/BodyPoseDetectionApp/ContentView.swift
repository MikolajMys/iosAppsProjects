//
//  ContentView.swift
//  BodyPoseDetectionApp
//
//  Created by Mikołaj Myśliński on 26/10/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = FrameHandler()
    @State private var isDetectionActive = false  // Dodajemy stan kontrolujący wyświetlanie szkieletu
    
    var body: some View {
        ZStack {
            FrameView(image: model.frame)  // Kamera działa cały czas
            
            if isDetectionActive {  // Wyświetlamy szkielet tylko, jeśli detekcja jest aktywna
                SkeletonView(landmarks: model.poseDetector.bodyLandmarks)
            }
            
            VStack {
                Spacer()
                Button(action: {
                    isDetectionActive.toggle()
                }) {
                    Text(isDetectionActive ? "Start detecting" : "Stop detecting")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                }
            }
        }
        .onAppear {
            model.startDetection() // Kamera startuje od razu po pojawieniu się widoku
        }
    }
}
