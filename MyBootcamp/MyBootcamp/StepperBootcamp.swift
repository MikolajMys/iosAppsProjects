//
//  StepperBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 05/10/2024.
//

import SwiftUI

struct StepperBootcamp: View {
    
    @State var stepperValue: Int = 10
    @State var widthIncrement: CGFloat = 0.0
    
    var body: some View {
        VStack {
            Stepper("Stepper: \(stepperValue)", value: $stepperValue)
                .padding(.horizontal, 50)
            
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 100 + widthIncrement, height: 100)
            
            Stepper("Stepper 2") {
                // increment
                incrementWidth(amount: 10.0)
            } onDecrement: {
                // decrement
                decrementWidth(amount: 10.0)
            }
            .padding(.horizontal, 50)
        }
    }
    func incrementWidth(amount: CGFloat) {
        withAnimation(.easeInOut) {
            widthIncrement += amount
        }
    }
    func decrementWidth(amount: CGFloat) {
        withAnimation(.easeInOut) {
            widthIncrement -= amount
        }
    }
}

struct StepperBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StepperBootcamp()
    }
}
