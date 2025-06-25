//
//  CanvasUIView.swift
//  NumberDrawingDetectionApp
//
//  Created by Mikołaj Myśliński on 25/06/2025.
//

import UIKit

class CanvasUIView: UIView {

    private var path = UIBezierPath()
    private var previousTouch: CGPoint?
    private var segmentIndex: Int = 0
    
    private var colors: [UIColor] = [
        UIColor(red: 0.85, green: 0.62, blue: 1.00, alpha: 1.0),
        UIColor(red: 0.55, green: 0.75, blue: 1.00, alpha: 1.0),
        UIColor(red: 0.60, green: 1.00, blue: 0.85, alpha: 1.0),
        UIColor(red: 1.00, green: 0.85, blue: 0.60, alpha: 1.0)
    ]
    
    private var coloredStrokes: [(path: UIBezierPath, color: UIColor)] = []
    
    var onDrawingEnd: ((UIImage?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.isMultipleTouchEnabled = false
        path.lineWidth = 20
        path.lineCapStyle = .round
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            previousTouch = touch.location(in: self)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let previousPoint = previousTouch else { return }
        let currentPoint = touch.location(in: self)
        path.move(to: previousPoint)
        path.addLine(to: currentPoint)
        previousTouch = currentPoint
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onDrawingEnd?(asImage())
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let lineWidth: CGFloat = 20.0
//        path.lineWidth = lineWidth
//        path.lineCapStyle = .round
//        path.lineJoinStyle = .round

        let colors: [CGColor] = [
            UIColor(red: 0.85, green: 0.62, blue: 1.00, alpha: 1.0).cgColor,
            UIColor(red: 0.55, green: 0.75, blue: 1.00, alpha: 1.0).cgColor,
            UIColor(red: 0.60, green: 1.00, blue: 0.85, alpha: 1.0).cgColor,
            UIColor(red: 1.00, green: 0.85, blue: 0.60, alpha: 1.0).cgColor
        ]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace,
                                colors: colors as CFArray,
                                locations: [0.0, 0.33, 0.66, 1.0])!
        
        context.saveGState()
        context.setLineWidth(lineWidth)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        context.addPath(path.cgPath)
        context.replacePathWithStrokedPath()
        context.clip()
        
        let expandedBounds = path.bounds.insetBy(dx: -lineWidth / 2, dy: -lineWidth / 2)

        context.drawLinearGradient(
            gradient,
            start: CGPoint(x: expandedBounds.minX, y: expandedBounds.midY),
            end: CGPoint(x: expandedBounds.maxX, y: expandedBounds.midY),
            options: []
        )
        context.restoreGState()
    }

    func clear() {
        path.removeAllPoints()
        setNeedsDisplay()
        onDrawingEnd?(nil)
    }

    func asImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 1.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}

