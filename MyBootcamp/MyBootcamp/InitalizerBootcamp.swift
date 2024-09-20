//
//  InitalizerBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 28/08/2024.
//

import SwiftUI

struct InitalizerBootcamp: View {
    
    let backgroundColor: Color
    let count: Int
    let title: String
    
    init(count: Int, fruit: Fruit) {
//        self.backgroundColor = backgroundColor
        self.count = count
//        self.title = title
//
//        if title == "Apples" {
//            self.backgroundColor = .red
//        } else {
//            self.backgroundColor = .orange
//        }
        if fruit == .apple {
            self.title = "Apples"
            self.backgroundColor = .red
        } else {
            self.title = "Oranges"
            self.backgroundColor = .orange
        }
        
    }
    
    enum Fruit {
        case apple
        case orange
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(count)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .underline()
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

struct InitalizerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            InitalizerBootcamp(count: 21, fruit: .apple)
            InitalizerBootcamp(count: 37, fruit: .orange)
        }
    }
}
