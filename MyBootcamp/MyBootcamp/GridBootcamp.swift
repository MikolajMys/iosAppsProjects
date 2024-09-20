//
//  GridBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 30/08/2024.
//

import SwiftUI

struct GridBootcamp: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil)
    ]
    
    var body: some View {
        ScrollView {
            
            Rectangle()
                .fill(Color.orange)
                .frame(height: 400)
            
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 6,
                pinnedViews: [.sectionHeaders],
                content: {
                    // Works
//                    Section(header: Text("Section 1")) {
//                        ForEach(0 ..< 20) { index in
//                            Rectangle()
//                                .frame(height: 150)
//                        }
//                    }
                    // Better
                    Section {
                        ForEach(0 ..< 20) { index in
                            Rectangle()
                                .frame(height: 150)
                        }
                    } header: {
                        Text("Section 1")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue)
                            .padding()
                    }
                    
                    Section {
                        ForEach(0 ..< 20) { index in
                            Rectangle()
                                .fill(Color.green)
                                .frame(height: 150)
                        }
                    } header: {
                        Text("Section 2")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.red)
                            .padding()
                    }
                })
            
//            Rectangle()
//                .fill(Color.white)
//                .frame(height: 400)
            // first grid
//            LazyVGrid(columns: columns) {
//                ForEach(0 ..< 50) { index in
//                    Rectangle()
//                        .frame(height: 150)
//                }
//            }
        }
    }
}

struct GridBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GridBootcamp()
    }
}
