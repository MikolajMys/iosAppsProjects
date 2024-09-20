//
//  ConditionalBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 07/09/2024.
//

import SwiftUI

struct ConditionalBootcamp: View {
    
    @State var showCircle: Bool = false
    @State var showRectangle: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            Button {
                isLoading.toggle()
            } label: {
                Text("IS LOADING: \(isLoading.description)")
                    .frame(width: 160, height: 20)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom, 300)

            
            if isLoading {
                ProgressView()
            }
            
//            VStack(spacing: 20) {
//                Button {
//                    showCircle.toggle() // changing false to true and true to false
//                } label: {
//                    Text("Circle Button: \(showCircle.description)")
//                        .frame(width: 160, height: 20)
//                        .foregroundColor(.white)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//
//                Button {
//                    showRectangle.toggle()
//                } label: {
//                    Text("Rectangle Button: \(showRectangle.description)")
//                        .frame(width: 190, height: 20)
//                        .foregroundColor(.white)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.bottom, 200)
//            }
//
//            if showCircle {
//                Circle()
//                    .frame(width: 100, height: 100)
//            }
//
//            if showRectangle {
//                Rectangle()
//                    .frame(width: 100, height: 100)
//            }
//
//            if showCircle || showRectangle {
//                RoundedRectangle(cornerRadius: 25)
//                    .frame(width: 200, height: 100)
//            }
            Spacer()
        }
    }
}

struct ConditionalBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalBootcamp()
    }
}
