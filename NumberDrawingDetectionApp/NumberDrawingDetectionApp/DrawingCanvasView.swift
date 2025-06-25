//
//  DrawingCanvasView.swift
//  NumberDrawingDetectionApp
//
//  Created by Mikołaj Myśliński on 25/06/2025.
//

import SwiftUI

struct DrawingCanvasView: UIViewRepresentable {
    @Binding var drawnImage: UIImage?
    @Binding var shouldClear: Bool

    class Coordinator: NSObject {
        var parent: DrawingCanvasView

        init(parent: DrawingCanvasView) {
            self.parent = parent
        }
        
        func drawingEnded(_ image: UIImage) {
            Task { @MainActor in
                self.parent.drawnImage = image
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> CanvasUIView {
        let view = CanvasUIView()
        view.onDrawingEnd = { optionalImage in
            guard let image = optionalImage else { return }
            context.coordinator.drawingEnded(image)
        }
        return view
    }

    func updateUIView(_ uiView: CanvasUIView, context: Context) {
        if shouldClear {
            uiView.clear()
            DispatchQueue.main.async {
                self.drawnImage = nil
                self.shouldClear = false
            }
        }
    }
}
