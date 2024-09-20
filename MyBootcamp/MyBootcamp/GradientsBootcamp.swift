//
//  GradientsBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 23/08/2024.
//

import SwiftUI

struct GradientsBootcamp: View {
    let color1 = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    let color2 = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(
                //Color.red
//                LinearGradient(
//                    gradient: Gradient(colors: [Color(color1), Color(color2)]),
//                    startPoint: .topLeading,
//                    endPoint: .bottom
//                )
//                RadialGradient(
//                    gradient: Gradient(colors: [Color(color1), Color(color2)]),
//                    center: .leading,
//                    startRadius: 5,
//                    endRadius: 400
//                )
                AngularGradient(
                    gradient: Gradient(colors: [Color(color1), Color(color2)]),
                    center: .topLeading,
                    angle: .degrees(180 + 45)
                )
            )
            .frame(width: 300, height: 200)
    }
}

struct GradientsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GradientsBootcamp()
    }
}
