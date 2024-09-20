//
//  ForEachBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 29/08/2024.
//

import SwiftUI

struct ForEachBootcamp: View {
    
    let data: [String] = ["Hi", "Hello", "Hey everyone"]
    let myString: String = "Hello"
    
    var body: some View {
        VStack {
//            ForEach(0..<10) { index in
//                HStack {
//                    Circle()
//                        .frame(width: 30, height: 30)
//                    Text("Index is: \(index)")
//                }
//            }
            Spacer()
            // Works ...
//            ForEach(data.indices) { index in
//                Text("\(data[index]): \(index)")
//            }
            Spacer()
            // Better
            ForEach(data.indices, id: \.self) { index in
                Text("\(data[index]): \(index)")
            }
            Spacer()
            ForEach(Array(data.indices), id: \.self) { index in
                Text("\(data[index]): \(index)")
            }
            Spacer()
            ForEach(data, id: \.self) { item in
                Text(item)
            }
            Spacer()
            ForEach(0 ..< 100) { index in
                Circle()
                    .frame(height: 50)
            }
            
//            Text("ONE")
//            Text("TWO")
//            Text("THREE")
            // ... retyping
        }
    }
}

struct ForEachBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ForEachBootcamp()
    }
}
