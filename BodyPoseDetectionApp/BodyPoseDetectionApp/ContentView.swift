//
//  ContentView.swift
//  BodyPoseDetectionApp
//
//  Created by Mikołaj Myśliński on 26/10/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = FrameHandler()
    
    var body: some View {
        ZStack {
            FrameView(image: model.frame)
            SkeletonView(landmarks: model.poseDetector.bodyLandmarks) // Rysowanie punktów
        }
        .onAppear {
            model.startDetection()
        }
    }
}

