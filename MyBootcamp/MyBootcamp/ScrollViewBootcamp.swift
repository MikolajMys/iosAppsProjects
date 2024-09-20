//
//  ScrollViewBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 29/08/2024.
//

import SwiftUI

struct ScrollViewBootcamp: View {
    var body: some View {
//        ScrollView {
//            VStack {
//                ForEach(0 ..< 50) { index in
//                    Rectangle()
//                        .fill(Color.blue)
//                        .frame(height: 300)
//                }
//            }
//        }
//        ScrollView(.horizontal, showsIndicators: false, content: {
//            HStack {
//                ForEach(0 ..< 50) { index in
//                    Rectangle()
//                        .fill(Color.blue)
//                        .frame(width: 300, height: 300)
//                }
//            }
//        })
        ScrollView {
            // Lazy - creates only visible items on the screen
            LazyVStack {
                ForEach(0..<100) { index in
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        LazyHStack {
                            ForEach(0..<20) { index in
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.white)
                                    .frame(width: 200, height: 150)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    })
//                    RoundedRectangle(cornerRadius: 25.0)
//                        .fill(Color.white)
//                        .frame(width: 200, height: 150)
//                        .shadow(radius: 10)
//                        .padding()
                }
            }
        }
    }
}

struct ScrollViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewBootcamp()
    }
}
