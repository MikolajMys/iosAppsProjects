//
//  AnimationBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 08/09/2024.
//

import SwiftUI

struct AnimationBootcamp: View {
    
    @State var isAnimated: Bool = false
    
    var body: some View {
        VStack {
            Button("Button: \(isAnimated.description)") {
                withAnimation(
                    .default
                    .repeatForever(autoreverses: true)
                ) {
                    isAnimated.toggle()
                }
            }
            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100: 300
                )
                // rotation before offset
                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                .offset(y: isAnimated ? 300 : 0)
//                .animation(
//                    .default
//                    .repeatForever(autoreverses: true)
//                ) //old
                //.animation(.default.repeatForever(autoreverses: true), value: isAnimated) // Not great solution
            
            Spacer()
        }
    }
}

struct AnimationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBootcamp()
    }
}
