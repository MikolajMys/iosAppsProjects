//
//  ContentView.swift
//  BodyPoseDetectionApp
//
//  Created by Mikołaj Myśliński on 26/10/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = FrameHandler()
    @State private var isDetectionActive = false
    
    var body: some View {
        let buttonColors: [Color] = isDetectionActive ?
        [.red, .orange, .yellow] :
        [
            Color(red: 0.85, green: 0.62, blue: 1.00),
            Color(red: 0.55, green: 0.75, blue: 1.00),
            Color(red: 0.60, green: 1.00, blue: 0.85),
            Color(red: 1.00, green: 0.85, blue: 0.60)
        ]
        ZStack {
            FrameView(isDetectionActive: $isDetectionActive, image: model.frame)
            
            if isDetectionActive {
                SkeletonView(landmarks: model.poseDetector.bodyLandmarks)
                    .ignoresSafeArea(edges: .all)
            }
            
            VStack {
                Spacer()
                Button(action: {
                    //isDetectionActive.toggle()
                    if self.isDetectionActive {
                        model.stopDetection()
                        self.isDetectionActive = false
                    } else {
                        model.startDetection()
                        self.isDetectionActive = true
                    }
                }) {
                    Text(isDetectionActive ? "Stop detecting" : "Start detecting")
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
        .onAppear {
            //model.startDetection()
        }
    }
}
