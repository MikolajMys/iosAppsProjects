//
//  ContentView.swift
//  FaceDetectionApp
//
//  Created by Mikołaj Myśliński on 14/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image: UIImage = UIImage(named: "test")!
    @ObservedObject var faceDetector = DetectFaces()
    
    let bgColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
//        ZStack {
//            Color(bgColor).opacity(0.5).ignoresSafeArea()
//            VStack {
//                ZStack {
//                    if faceDetector.outputImage != nil {
//                        Image(uiImage: faceDetector.outputImage!)
//                            .resizable()
//                            .scaledToFit()
//                    } else {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                    }
//                }
//                .cornerRadius(30)
//                .padding(20)
//                .shadow(color: .black, radius: 10, x: 5, y: 5)
//                //.padding(.bottom, 50)
//                .background(Color.black.opacity(0.5))
//                .cornerRadius(30)
//
//                Button {
//                    faceDetector.inputImage = image
//                    faceDetector.detectFaces(in: image)
//                } label: {
//                    Text("Process Image")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.black.opacity(0.5))
//                        .cornerRadius(20)
//                }
//            }
//        }
        if faceDetector.outputImage != nil {
            Image(uiImage: faceDetector.outputImage!)
                .resizable()
                .scaledToFit()
        } else {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        Button {
            faceDetector.inputImage = image
            faceDetector.detectFaces(in: image)
        } label: {
            Text("Process Image")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
