//
//  ImageBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 24/08/2024.
//

import SwiftUI

struct ImageBootcamp: View {
    var body: some View {
        Image("apple")
            //.renderingMode(.template) //let me change color of my image logo (only PNG background)
            .resizable()
            //.aspectRatio(contentMode: .fit)
            //.scaledToFit()
            .scaledToFit()
            .frame(width: 300, height: 200)
            .foregroundColor(.green)
            //.clipped()
            //.cornerRadius(150) //setting half of the number in frame gets me the circle!!!
            //.clipShape(
                //Circle()
                //RoundedRectangle(cornerRadius: 25.0)
                //Ellipse()
                //Circle()
            //)
    }
}

struct ImageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ImageBootcamp()
    }
}
