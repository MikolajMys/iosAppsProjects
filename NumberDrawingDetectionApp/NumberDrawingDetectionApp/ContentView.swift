//
//  ContentView.swift
//  NumberDrawingDetectionApp
//
//  Created by Mikołaj Myśliński on 25/06/2025.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var image: UIImage? = nil
    @State private var prediction: String = "Draw a number from 0 to 9"
    @State private var shouldClear: Bool = false

    private let model: MNISTClassifier?

    init() {
        do {
            let configuration = MLModelConfiguration()
            //CPU
            //configuration.computeUnits = .cpuOnly
            //GPU
            //configuration.computeUnits = .cpuAndGPU
            //ANE
            configuration.computeUnits = .cpuAndNeuralEngine
            model = try MNISTClassifier(configuration: configuration)
        } catch {
            print("Model initialization error: \(error.localizedDescription)")
            model = nil
        }
    }

    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    .indigo,
                    .purple,
                    .pink,
                    .red,
                    .orange,
                    .yellow
                ]),
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
            VStack {
                Text(prediction)
                    .font(.headline)
                    .bold()
                    .padding()
                
                DrawingCanvasView(drawnImage: $image, shouldClear: $shouldClear)
                    .frame(width: 280, height: 280)
                    .padding()
                
                HStack {
                    Button("Clear") {
                        image = nil
                        prediction = "Draw a number from 0 to 9"
                        shouldClear = true
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Detect") {
                        classifyDrawing()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .background(.gray)
        }
        .ignoresSafeArea()
    }

    func classifyDrawing() {
        guard let uiImage = image else { return }
        
        guard let model = model else {
            prediction = "Model is not available"
            return
        }
        
        let fixedImage = uiImage.fixedOrientationAndFlip()

        let resized = resizeImage(image: fixedImage, to: CGSize(width: 28, height: 28))
        guard let buffer = resized.toCVPixelBuffer() else {
            prediction = "Failed to process image"
            return
        }

        do {
            let start = CFAbsoluteTimeGetCurrent()
            let result = try model.prediction(image: buffer)
            let end = CFAbsoluteTimeGetCurrent()
            let elapsed = (end - start) * 1000
            
            let predictedLabel = result.classLabel
            let confidence = result.labelProbabilities[predictedLabel] ?? 0
            
            prediction = "Detected: \(predictedLabel)"
            shouldClear = true
            
            print("Prediction time: \(String(format: "%.6f", elapsed)) ms")
            print("Confidence: \(String(format: "%.2f", confidence * 100))%")
            
        } catch {
            prediction = "Error: \(error.localizedDescription)"
        }
    }

    func resizeImage(image: UIImage, to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized ?? image
    }
}

#Preview {
    ContentView()
}
