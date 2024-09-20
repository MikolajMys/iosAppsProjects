//
//  ExtractSubviewsBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 05/09/2024.
//

import SwiftUI

struct ExtractSubviewsBootcamp: View {
    
    let color1 = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
        ZStack {
            // background
            Color(color1)
                .ignoresSafeArea(edges: .all)
            
            // content
            contentLayer
        }
    }
    
    var contentLayer: some View {
        HStack {
            MyItem(title: "Apples", count: 10, color: .red)
            MyItem(title: "Oranges", count: 20, color: .orange)
            MyItem(title: "Bananas", count: 30, color: .yellow)
        }
    }
    
//    var myItem: some View {
//        VStack {
//            Text("1")
//            Text("Apples")
//        }
//        .padding()
//        .background(Color.red)
//        .cornerRadius(10)
//    }
}

struct ExtractSubviewsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ExtractSubviewsBootcamp()
    }
}

struct MyItem: View {
    
    let title: String
    let count: Int
    let color: Color
    
    var body: some View {
        VStack {
            Text("\(count)")
            Text(title)
        }
        .padding()
        .background(color)
        .cornerRadius(10)
    }
}
