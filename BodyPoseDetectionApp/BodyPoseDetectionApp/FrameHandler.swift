//
//  FrameHandler.swift
//  BodyPoseDetectionApp
//
//  Created by Mikołaj Myśliński on 26/10/2024.
//

import AVFoundation
import CoreImage
import SwiftUI

class FrameHandler: NSObject, ObservableObject {
    @Published var frame: CGImage?
    @Published var poseDetector = PoseDetector()
    @Published var isDetectionRunning = false
    let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let context = CIContext()
    private let visionQueue = DispatchQueue(label: "visionQueue", qos: .userInitiated)
    private var lastProcessedTime = Date()
    
    var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)

            // Determine if the user previously authorized camera access.
            var isAuthorized = status == .authorized

            // If the system hasn't determined the user's authorization status,
            // explicitly prompt them for approval.
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }

            return isAuthorized
        }
    }
    //func startDetection() {
//    override init() {
//        super.init()
//        sessionQueue.async { [unowned self] in
//            Task {
//                guard await isAuthorized else { return }
//                await self.setUpCaptureSession()
//                self.captureSession.startRunning()
//            }
//        }
//    }
    
    override init() {
        super.init()
        setupSession()
    }
    
    private func setupSession() {
        sessionQueue.async { [unowned self] in
            Task {
                guard await isAuthorized else { return }
                await self.setUpCaptureSession()
            }
        }
    }
    
    func startDetection() {
        isDetectionRunning = true
        captureSession.startRunning()
    }

    func stopDetection() {
        isDetectionRunning = false
        captureSession.stopRunning()
        poseDetector.bodyLandmarks.removeAll()
    }

    func setUpCaptureSession() async {
        captureSession.sessionPreset = .medium
        let videoOutput = AVCaptureVideoDataOutput()
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        videoOutput.setSampleBufferDelegate(self, queue: visionQueue)
        guard captureSession.canAddOutput(videoOutput) else { return }
        captureSession.addOutput(videoOutput)
        videoOutput.connection(with: .video)?.videoOrientation = .portrait
    }
}

extension FrameHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Sprawdzamy, czy od ostatniego przetworzenia minęło co najmniej 0,15 sekundy
        let currentTime = Date()
        guard currentTime.timeIntervalSince(lastProcessedTime) > 0.15,
              let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        
        lastProcessedTime = currentTime
        
        DispatchQueue.main.async { [unowned self] in
            self.poseDetector.processImage(cgImage)
            self.frame = cgImage
        }
    }
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
}


//struct PreviewLayerView: UIViewRepresentable {
//    var session: AVCaptureSession
//
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView()
//        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer.videoGravity = .resizeAspectFill // Ustawienie właściwości .resizeAspectFill
//        previewLayer.frame = view.bounds
//        view.layer.addSublayer(previewLayer)
//        
//        // Ensure layer resizes with view
//        DispatchQueue.main.async {
//            previewLayer.frame = view.bounds
//        }
//        
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        if let previewLayer = uiView.layer.sublayers?.compactMap({ $0 as? AVCaptureVideoPreviewLayer }).first {
//            previewLayer.frame = uiView.bounds
//        }
//    }
//}
