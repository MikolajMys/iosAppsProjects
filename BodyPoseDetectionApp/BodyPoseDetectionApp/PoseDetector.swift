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
    private var bodyPoseRequest: VNDetectHumanBodyPoseRequest = {
        let request = VNDetectHumanBodyPoseRequest()
        
        if #available(iOS 15.0, *) {
            request.revision = VNDetectHumanBodyPoseRequest.currentRevision
        }
        
        //request.usesCPUOnly = true //Detection works on CPU
        request.usesCPUOnly = false //System decides whether it works on GPU or ANE
        
        return request
    }()
    
    private let visionQueue = DispatchQueue(
        label: "com.yourApp.poseDetection",
        qos: .userInteractive,
        autoreleaseFrequency: .workItem
    )
    
    func processImage(_ image: CGImage) {
        let handler = VNImageRequestHandler(
            cgImage: image,
            orientation: .up,
            options: [:]
        )
        
        visionQueue.async { [weak self] in
            do {
                try handler.perform([self?.bodyPoseRequest ?? VNDetectHumanBodyPoseRequest()])
                
                if let results = self?.bodyPoseRequest.results?.first as? VNHumanBodyPoseObservation {
                    DispatchQueue.main.async {
                        self?.updateLandmarks(for: results)
                    }
                }
            } catch {
                print("Error in body pose detection: \(error.localizedDescription)")
            }
        }
    }

    private func updateLandmarks(for observation: VNHumanBodyPoseObservation) {
        do {
            //clearLandmarks()
            let recognizedPoints = try observation.recognizedPoints(.all)
            self.bodyLandmarks = recognizedPoints.mapValues { CGPoint(x: $0.x, y: 1 - $0.y) }
        } catch {
            print("Error in converting points: \(error)")
        }
    }
//    func clearLandmarks() {
//        self.bodyLandmarks.removeAll()
//    }
}
