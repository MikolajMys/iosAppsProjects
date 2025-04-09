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
        private var lastClassificationDate = Date(timeIntervalSince1970: 0)
        private let classificationInterval: TimeInterval = 0.3
        let parent: CameraView
        let classifier: EmotionClassifier

        init(parent: CameraView, classifier: EmotionClassifier) {
            self.parent = parent
            self.classifier = classifier
        }

        func captureOutput(_ output: AVCaptureOutput,
                           didOutput sampleBuffer: CMSampleBuffer,
                           from connection: AVCaptureConnection) {
            let now = Date()
            guard now.timeIntervalSince(lastClassificationDate) > classificationInterval else {
                return // Za wcześnie na kolejną klasyfikację
            }

            lastClassificationDate = now

            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

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

        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
