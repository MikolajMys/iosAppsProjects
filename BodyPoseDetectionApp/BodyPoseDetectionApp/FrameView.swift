//
//  FrameView.swift
//  BodyPoseDetectionApp
//
//  Created by Mikołaj Myśliński on 26/10/2024.
//

import SwiftUI

struct FrameView: View {
    @Binding var isDetectionActive: Bool
    var image: CGImage?
    private let label = Text("frame")
    
    var body: some View {
        if isDetectionActive {
            if let image = image {
                Image(image, scale: 1.0, orientation: .up, label: label)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
        } else {
            VStack(spacing: 50) {
                Label("Press button to start detection", systemImage: "hand.tap.fill")
                    .font(.system(size: 20, weight: .bold))
                ProgressView()
                    .scaleEffect(2)
            }
            .tint(.primary)
        }
    }
}
