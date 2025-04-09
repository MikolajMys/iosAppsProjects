//
//  CameraView.swift
//  EmotionDetectionApp
//
//  Created by Mikołaj Myśliński on 08/04/2025.
//

import SwiftUI
import AVFoundation
import Vision

struct CameraView: UIViewRepresentable {
    class CameraCoordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        let parent: CameraView
        let classifier: EmotionClassifier

        init(parent: CameraView, classifier: EmotionClassifier) {
            self.parent = parent
            self.classifier = classifier
        }

        func captureOutput(_ output: AVCaptureOutput,
                           didOutput sampleBuffer: CMSampleBuffer,
                           from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            
            // Call the classifier on a background thread
            DispatchQueue.global(qos: .userInitiated).async {
                self.classifier.classify(image: ciImage)
            }
        }
    }

    @ObservedObject var classifier: EmotionClassifier

    func makeCoordinator() -> CameraCoordinator {
        CameraCoordinator(parent: self, classifier: classifier)
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        let session = AVCaptureSession()
        session.sessionPreset = .medium

        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: camera) else {
            return view
        }

        session.addInput(input)

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        previewLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(previewLayer)

        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "videoQueue"))
        session.addOutput(output)

        session.startRunning()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
