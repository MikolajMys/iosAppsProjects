//
//  ExtractedFunctionsBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 05/09/2024.
//

import SwiftUI

struct ExtractedFunctionsBootcamp: View {
    
    @State var backgroundColor: Color = Color.pink
    
    var body: some View {
        ZStack {
            // background ..
            backgroundColor
                // same stuff:
                //.edgesIgnoringSafeArea(.all)
                //.ignoresSafeArea(edges: .all)
                .ignoresSafeArea()
            
            // content ..
            contentLayer
        }
        // background make too:
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(backgroundColor)
    }
    
    var contentLayer: some View {
        VStack {
            Text("Title")
                .font(.largeTitle)
            Button {
                buttonPressed()
            } label: {
                Text("PRESS ME")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
        }
    }
    
    func buttonPressed() {
        backgroundColor = .yellow
    }
}

struct ExtractedFunctionsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ExtractedFunctionsBootcamp()
    }
}
