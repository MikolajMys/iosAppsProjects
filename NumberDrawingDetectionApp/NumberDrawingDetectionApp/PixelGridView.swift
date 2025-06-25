//
//  PixelGridView.swift
//  NumberDrawingDetectionApp
//
//  Created by Mikołaj Myśliński on 25/06/2025.
//

import SwiftUI

struct PixelGridView: View {
    @Binding var pixels: [[Bool]]
    let gridSize = 28

    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<gridSize, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(0..<gridSize, id: \.self) { col in
                        Rectangle()
                            .fill(pixels[row][col] ? Color.white : Color.black)
                            .frame(width: 10, height: 10)
                            .onTapGesture {
                                pixels[row][col].toggle()
                            }
                    }
                }
            }
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(8)
    }
}
