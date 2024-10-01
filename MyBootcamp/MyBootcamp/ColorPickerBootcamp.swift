//
//  ColorPickerBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 01/10/2024.
//

import SwiftUI

struct ColorPickerBootcamp: View {
    
    @State var backgroundColor: Color = .green
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            ColorPicker("Select a color",
                        selection: $backgroundColor,
                        supportsOpacity: true
            )
            .foregroundColor(.white)
            .padding()
            .background(Color.black)
            .cornerRadius(10)
            .font(.headline)
            .padding(50)
        }
    }
}

struct ColorPickerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerBootcamp()
    }
}
