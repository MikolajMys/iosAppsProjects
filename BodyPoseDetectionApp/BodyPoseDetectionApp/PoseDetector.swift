//
//  PoseDetector.swift
//  BodyPoseDetectionApp
//
//  Created by Mikołaj Myśliński on 27/10/2024.
//

import Vision
import SwiftUI

class PoseDetector: ObservableObject {
    @Published var bodyLandmarks: [VNHumanBodyPoseObservation.JointName: CGPoint] = [:]
    
    private var bodyPoseRequest = VNDetectHumanBodyPoseRequest()
    private let visionQueue = DispatchQueue(label: "visionQueue")
    
    func processImage(_ image: CGImage) {
        let handler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
        
        visionQueue.async { [weak self] in
            do {
                try handler.perform([self?.bodyPoseRequest ?? VNRequest()])
                if let results = self?.bodyPoseRequest.results?.first as? VNHumanBodyPoseObservation {
                    self?.updateLandmarks(for: results)
                }
            } catch {
                print("Error in body pose detection: \(error)")
            }
        }
    }

    private func updateLandmarks(for observation: VNHumanBodyPoseObservation) {
        do {
            let recognizedPoints = try observation.recognizedPoints(.all)
            DispatchQueue.main.async {
                self.bodyLandmarks = recognizedPoints.mapValues { CGPoint(x: $0.x, y: 1 - $0.y) }
            }
        } catch {
            print("Error in converting points: \(error)")
        }
    }
}
