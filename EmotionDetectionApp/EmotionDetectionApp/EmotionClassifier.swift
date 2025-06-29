//
//  EmotionClassifier.swift
//  EmotionDetectionApp
//
//  Created by Mikołaj Myśliński on 25/03/2025.
//

import Foundation
import CoreML
import Vision
import CoreImage

class EmotionClassifier: ObservableObject {
    @Published var detectedEmotion: String?
    @Published var isRunning = false
    
    private var model: VNCoreMLModel?
    private var request: VNCoreMLRequest?

    init() {
        do {
            let configuration = MLModelConfiguration()
            let emotionModel = try VNCoreMLModel(for: CNNEmotions(configuration: configuration).model)
            self.model = emotionModel
            
            self.request = VNCoreMLRequest(model: emotionModel) { [weak self] request, _ in
                self?.processResults(request.results)
            }
        } catch {
            assertionFailure("Nie można załadować modelu ML: \(error)")
        }
    }
    func start() { isRunning = true }
    func stop()  {
        isRunning = false
        detectedEmotion = nil
    }
    
    func classify(image: CIImage?) {
        guard let request = request, let image = image else {
            DispatchQueue.main.async {
                self.detectedEmotion = "Błąd analizy"
            }
            return
        }
        
        let handler = VNImageRequestHandler(ciImage: image, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Błąd analizy obrazu: \(error)")
        }
    }
    
    private func processResults(_ results: [Any]?) {
        guard let results = results as? [VNClassificationObservation], let topResult = results.first else {
            DispatchQueue.main.async {
                self.detectedEmotion = "Nie wykryto emocji"
            }
            return
        }
        
        DispatchQueue.main.async {
            self.detectedEmotion = topResult.identifier
        }
    }
}
