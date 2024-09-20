//
//  FrameBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 24/08/2024.
//

import SwiftUI

struct FrameBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            //.background(Color.green)
            //.frame(width: 300, height: 300, alignment: .leading)
            //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.red)
            .frame(height: 100, alignment: .bottom)
            .background(Color.orange)
            .frame(width: 150)
            .background(Color.purple)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(Color.pink)
            .frame(height: 400)
            .background(Color.green)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color.yellow)
    }
}

struct FrameBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FrameBootcamp()
    }
}
