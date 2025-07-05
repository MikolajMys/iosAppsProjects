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
            //CPU
            //configuration.computeUnits = .cpuOnly
            //GPU
            //configuration.computeUnits = .cpuAndGPU
            //ANE
            //configuration.computeUnits = .cpuAndNeuralEngine
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
        
        let start = CFAbsoluteTimeGetCurrent()
        do {
            try handler.perform([request])
            let end = CFAbsoluteTimeGetCurrent()
            let elapsed = end - start
            print("Czas klasyfikacji: \(String(format: "%.3f", elapsed)) sekund")
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
        
        let identifier = topResult.identifier
        let confidence = topResult.confidence

        DispatchQueue.main.async {
            self.detectedEmotion = identifier
        }

        print("""
        ➤ Wynik klasyfikacji::
        - Label: \(identifier)
        - Confidence: \(String(format: "%.2f", confidence * 100))%
        """)
    }
}
