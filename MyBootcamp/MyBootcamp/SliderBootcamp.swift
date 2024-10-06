//
//  SliderBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 06/10/2024.
//

import SwiftUI

struct SliderBootcamp: View {
    
    @State var sliderValue: Double = 3.0
    @State var detailColor: Color = .red
    
    var body: some View {
        VStack {
            Text("Rating:")
            Text(
                String(format: "%.0f", sliderValue)
                //"\(sliderValue)"
            )
            .foregroundColor(detailColor)
            // I
//            Slider(value: $sliderValue)
//                .padding(.horizontal, 90)
//                .tint(.red)
            // II
//            Slider(value: $sliderValue, in: 1.0...5.0)
//                .tint(.red)
            // III
//            Slider(value: $sliderValue, in: 1.0...5.0, step: 0.5)
            // IV
            Slider(
                value: $sliderValue,
                in: 1.0...5.0,
                step: 1.0) {
                    Text("Title") // doesnt show up
                } minimumValueLabel: {
                    Text("1")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                } maximumValueLabel: {
                    Text("5")
                        .font(.largeTitle)
                        .foregroundColor(.cyan)
                } onEditingChanged: { _ in
                    detailColor = .green
                }
                .padding(.horizontal,20)
                .tint(detailColor)
        }
    }
}

struct SliderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SliderBootcamp()
    }
}
