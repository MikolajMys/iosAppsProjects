//
//  FrameView.swift
//  BodyPoseDetectionApp
//
//  Created by Mikołaj Myśliński on 26/10/2024.
//

import SwiftUI

struct FrameView: View {
    var image: CGImage?
    private let label = Text("frame")
    
    var body: some View {
        if let image = image {
            Image(image, scale: 1.0, orientation: .up, label: label)
                .resizable()
                .aspectRatio(contentMode: .fill)  // Dopasowuje proporcje
                .edgesIgnoringSafeArea(.all)
        } else {
            //Color.black
            ProgressView()
        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
