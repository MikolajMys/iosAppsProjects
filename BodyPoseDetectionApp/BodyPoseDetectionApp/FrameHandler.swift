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
    let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let context = CIContext()
    
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
    
    override init() {
        super.init()
        sessionQueue.async { [unowned self] in
            Task {
                guard await isAuthorized else { return }
                await self.setUpCaptureSession()
                self.captureSession.startRunning()
            }
        }
    }

    func setUpCaptureSession() async {
        // guard await isAuthorized else { return }
        
        captureSession.sessionPreset = .medium
        
        let videoOutput = AVCaptureVideoDataOutput()
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        guard captureSession.canAddOutput(videoOutput) else { return }
        captureSession.addOutput(videoOutput)
        videoOutput.connection(with: .video)?.videoOrientation = .portrait
    }

}

extension FrameHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        
        //All UI updates on main queue
        DispatchQueue.main.async { [unowned self] in
            self.frame = cgImage
            self.poseDetector.processImage(cgImage)
        }
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        return cgImage
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

