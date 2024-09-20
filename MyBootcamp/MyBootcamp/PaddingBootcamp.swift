//
//  PaddingAndSpacerBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 28/08/2024.
//

import SwiftUI

struct PaddingBootcamp: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, World!")
            //            .background(Color.yellow)
            //            .frame(width: 100, height: 100)
            //            .padding()
            //            .padding(.all, 10)
            //            .padding(.leading, 20)
            //            .background(Color.blue)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            //            .frame(maxWidth: .infinity, alignment: .leading)
            //            .background(Color.red)
            //            .padding(.leading, 20)
            Text("This is the description of what we will do on this screen. It is multiple lines and we will align the text to the leading edge.")
        }
        //.background(Color.blue)
        .padding()
        .padding(.vertical, 10)
        .background(
            Color.white
                .cornerRadius(10)
                .shadow(
                    color: Color.black.opacity(0.3),
                    radius: 10,
                    x: 0.0,
                    y: 010
                )
        )
        .padding(.horizontal, 10)
        //.background(Color.green)
    }
}

struct PaddingAndSpacerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PaddingBootcamp()
    }
}
