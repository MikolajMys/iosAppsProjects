//
//  ContentView.swift
//  FaceDetectionApp
//
//  Created by Mikołaj Myśliński on 14/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentIndex: Int = 0
    @State private var image: UIImage = UIImage(named: "photo0")!
    @State private var images: [UIImage] = [
        UIImage(named: "photo0")!,
        UIImage(named: "photo1")!,
        UIImage(named: "photo2")!,
        UIImage(named: "photo3")!,
        UIImage(named: "photo4")!,
        UIImage(named: "photo5")!,
        UIImage(named: "photo6")!
    ]
    @State private var detectedFaces: [Int] = [0,0,0,0,0,0,0]
    
    @State private var detectedImages: [UIImage: UIImage] = [:]
    @State private var isDetectingImage = false
    @State private var refresh = UUID()
    
    @ObservedObject var faceDetector = DetectFaces()
    
    let bgColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
        ZStack {
            Color(bgColor).opacity(0.5).ignoresSafeArea()
            VStack {
                VStack(alignment: .center) {
                    if isDetectingImage {
                        ProgressView("Detecting...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            //.background(Color(bgColor).opacity(0.5))
                            .cornerRadius(30)
                    } else {
                        TabView(selection: $currentIndex) {
                            ForEach(images.indices, id: \.self) { index in
    //                            Image(uiImage: image)
    //                                .resizable()
    //                                .scaledToFit()
    //                                .tag(image)
                                if let detectedImage = detectedImages[images[index]] {
                                    Image(uiImage: detectedImage)
                                        .resizable()
                                        .scaledToFit()
                                        .tag(index)
                                } else {
                                    Image(uiImage: images[index])
                                        .resizable()
                                        .scaledToFit()
                                        .tag(index)
                                    
                                }
                            }
                            .cornerRadius(30)
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .disabled(isDetectingImage)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            isDetectingImage = true
                            faceDetector.inputImage = images[currentIndex]
                            faceDetector.detectFaces(in: images[currentIndex])
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if let output = faceDetector.outputImage {
                                    detectedImages[images[currentIndex]] = output
                                }
                                detectedFaces[currentIndex] = faceDetector.detectedFacesCount
                                isDetectingImage = false
                                refresh = UUID()
                            }
                        } label: {
                            Image(systemName: "face.smiling")
                                .font(.largeTitle)
                                .tint(Color.white)
                        }
                        .disabled(isDetectingImage)
                        Spacer()
                        Text("Detected Faces: \(detectedFaces[currentIndex])")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .disabled(isDetectingImage)
                        Spacer()
                        Button {
                            isDetectingImage = true
                            //faceDetector.outputImage = nil
                            detectedImages[images[currentIndex]] = nil
                            detectedFaces[currentIndex] = 0
                            isDetectingImage = false
                            refresh = UUID()
                        } label: {
                            Image(systemName: "gobackward")
                                .font(.largeTitle)
                                .tint(Color.white)
                        }
                        .disabled(isDetectingImage)
                    }
                }
                .padding(20)
                .shadow(color: .black, radius: 10, x: 5, y: 5)
                .frame(height: 500)
                //.padding(.bottom, 20)
                .background(Color.black.opacity(0.5))
                .cornerRadius(30)
                .id(refresh)
            }
        }
//        if faceDetector.outputImage != nil {
//            Image(uiImage: faceDetector.outputImage!)
//                .resizable()
//                .scaledToFit()
//        } else {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
//        }
//        Button {
//            faceDetector.inputImage = image
//            faceDetector.detectFaces(in: image)
//        } label: {
//            Text("Process Image")
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
