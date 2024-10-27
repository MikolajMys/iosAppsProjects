//
//  SkeletonView.swift
//  BodyPoseDetectionApp
//
//  Created by Mikołaj Myśliński on 27/10/2024.
//

import SwiftUI
import Vision

struct SkeletonView: View {
    let landmarks: [VNHumanBodyPoseObservation.JointName: CGPoint]
    
    // Define pairs of joints to connect with lines
    let jointPairs: [(VNHumanBodyPoseObservation.JointName, VNHumanBodyPoseObservation.JointName)] = [
        (.leftShoulder, .rightShoulder),
        (.leftShoulder, .leftElbow),
        (.rightShoulder, .rightElbow),
        (.leftElbow, .leftWrist),
        (.rightElbow, .rightWrist),
        (.leftHip, .rightHip),
        (.leftHip, .leftKnee),
        (.rightHip, .rightKnee),
        (.leftKnee, .leftAnkle),
        (.rightKnee, .rightAnkle)
    ]

    var body: some View {
        GeometryReader { geometry in
            // Draw red circles for each joint
            ForEach(Array(landmarks.keys), id: \.self) { key in
                if let point = landmarks[key] {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                        .position(x: point.x * geometry.size.width, y: point.y * geometry.size.height)
                }
            }

            // Draw lines connecting the specified pairs of joints
            ForEach(jointPairs.indices, id: \.self) { index in
                let pair = jointPairs[index]
                if let startPoint = landmarks[pair.0], let endPoint = landmarks[pair.1] {
                    Path { path in
                        path.move(to: CGPoint(
                            x: startPoint.x * geometry.size.width,
                            y: startPoint.y * geometry.size.height
                        ))
                        path.addLine(to: CGPoint(
                            x: endPoint.x * geometry.size.width,
                            y: endPoint.y * geometry.size.height
                        ))
                    }
                    .stroke(Color.blue, lineWidth: 3)
                }
            }
        }
    }
}
