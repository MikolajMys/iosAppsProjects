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
    @State private var prediction: String = "Narysuj cyfrę od 0 do 9"
    @State private var shouldClear: Bool = false

    private let model: MNISTClassifier?

    init() {
        do {
            model = try MNISTClassifier(configuration: MLModelConfiguration())
        } catch {
            print("Błąd inicjalizacji modelu: \(error.localizedDescription)")
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
                    Button("Wyczyść") {
                        image = nil
                        prediction = "Narysuj cyfrę od 0 do 9"
                        shouldClear = true
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Rozpoznaj") {
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
            prediction = "Model nie jest dostępny"
            return
        }
        
        let fixedImage = uiImage.fixedOrientationAndFlip()

        let resized = resizeImage(image: fixedImage, to: CGSize(width: 28, height: 28))
        guard let buffer = resized.toCVPixelBuffer() else {
            prediction = "Nie udało się przetworzyć obrazu"
            return
        }

        do {
            let result = try model.prediction(image: buffer)
            let confidence = result.labelProbabilities[result.classLabel] ?? 0
            prediction = "Rozpoznano: \(result.classLabel) z pewnością \(String(format: "%.0f", confidence*100))%"
            shouldClear = true
        } catch {
            prediction = "Błąd: \(error.localizedDescription)"
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
