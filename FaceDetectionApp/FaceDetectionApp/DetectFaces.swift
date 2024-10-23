//
//  DetectFaces.swift
//  FaceDetectionApp
//
//  Created by Mikołaj Myśliński on 14/10/2024.
//

import SwiftUI
import Vision

class DetectFaces: ObservableObject {
    var inputImage: UIImage = UIImage()
    @Published var outputImage: UIImage?
    @Published var detectedFacesCount: Int = 0
    private var detectedFaces: [VNFaceObservation] = [VNFaceObservation()]
    
    func detectFaces(in inputImage: UIImage) {
        guard let ciImage = CIImage(image: inputImage) else {
            fatalError("Can't convert image to ciimage")
        }
        let request = VNDetectFaceRectanglesRequest(completionHandler: self.handleFacesData)
        
        #if targetEnvironment(simulator)
        request.usesCPUOnly = true
        #else
        request.usesCPUOnly = false
        #endif
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch let reqErr {
            print("Failed to perform request: ", reqErr)
        }
    }
    
    func handleFacesData(request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let result = request.results as? [VNFaceObservation] else {
                return
            }
            self.detectedFaces = result
            self.detectedFacesCount = result.count
            for face in self.detectedFaces {
                self.addRectToFace(result: face)
            }
            
            self.outputImage = self.inputImage
        }
    }
    
    func addRectToFace(result: VNFaceObservation) {
        let imageSize = CGSize(width: inputImage.size.width, height: inputImage.size.height)
        
        let boundingBox = result.boundingBox
        let scaleBox = CGRect(
            x: boundingBox.origin.x * imageSize.width,
            y: (1 - boundingBox.origin.y - boundingBox.size.height) * imageSize.height,
            width: boundingBox.size.width * imageSize.width,
            height: boundingBox.size.height * imageSize.height
        )
        
        let faceCenter = CGPoint(
            x: scaleBox.midX,
            y: scaleBox.midY
        )
        
        let normalizedRect = VNNormalizedRectForImageRect(scaleBox, Int(imageSize.width), Int(imageSize.height))
        
        UIGraphicsBeginImageContext(inputImage.size)
        inputImage.draw(at: .zero)
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(5.0)
        context.stroke(CGRect(x: normalizedRect.origin.x * imageSize.width, y: normalizedRect.origin.y * imageSize.height, width: normalizedRect.size.width * imageSize.width, height: normalizedRect.size.height * imageSize.height))

        context.setFillColor(UIColor.red.cgColor)
        

        let dotRadius: CGFloat = 10.0
        let dotRect = CGRect(
            x: faceCenter.x - dotRadius / 2,
            y: faceCenter.y - dotRadius / 2,
            width: dotRadius,
            height: dotRadius
        )
        context.fillEllipse(in: dotRect)
        
        inputImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
}
