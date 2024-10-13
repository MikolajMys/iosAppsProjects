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
    private var detectedFaces: [VNFaceObservation] = [VNFaceObservation()]
    
    func detectFaces(in inputImage: UIImage) {
        guard let ciImage = CIImage(image: inputImage) else {
            fatalError("Can't convert image to ciimage")
        }
        let request = VNDetectFaceRectanglesRequest(completionHandler: self.handleFacesData)
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch let reqErr {
            print("Failed to perform request: ", reqErr)
        }
    }
    
    func handleFacesData(request: VNRequest, error: Error) {
        DispatchQueue.main.async {
            guard let result = request.results as? [VNFaceObservation] else {
                return
            }
            self.detectedFaces = result
            for faces in self.detectedFaces {
                
            }
            
            self.outputImage = self.inputImage
        }
    }
}
