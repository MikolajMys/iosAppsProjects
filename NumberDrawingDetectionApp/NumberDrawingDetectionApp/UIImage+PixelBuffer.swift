//
//  UIImage+PixelBuffer.swift
//  NumberDrawingDetectionApp
//
//  Created by Mikołaj Myśliński on 25/06/2025.
//

import UIKit
import CoreML

extension UIImage {
    func toCVPixelBuffer() -> CVPixelBuffer? {
        let width = 28
        let height = 28

        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue!,
            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue!
        ] as CFDictionary

        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_OneComponent8,
            attrs,
            &pixelBuffer
        )

        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, [])

        guard let context = CGContext(
            data: CVPixelBufferGetBaseAddress(buffer),
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: CGColorSpaceCreateDeviceGray(),
            bitmapInfo: CGImageAlphaInfo.none.rawValue
        ) else {
            return nil
        }

        UIGraphicsPushContext(context)
        draw(in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        UIGraphicsPopContext()

        CVPixelBufferUnlockBaseAddress(buffer, [])

        return buffer
    }
    
    func fixedOrientationAndFlip() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }

        context.translateBy(x: size.width / 2, y: size.height / 2)
        context.rotate(by: .pi)
        context.scaleBy(x: -1.0, y: 1.0)

        self.draw(in: CGRect(x: -size.width / 2,
                             y: -size.height / 2,
                             width: size.width,
                             height: size.height))

        let fixedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return fixedImage ?? self
    }
}
