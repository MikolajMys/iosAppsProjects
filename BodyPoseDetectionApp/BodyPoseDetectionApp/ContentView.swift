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
        // Preview layer with aspect fill
//            PreviewLayerView(session: model.captureSession)
//                .ignoresSafeArea()
        
        // FrameView to overlay additional processing
        FrameView(image: model.frame)
            .ignoresSafeArea()
    }
}

