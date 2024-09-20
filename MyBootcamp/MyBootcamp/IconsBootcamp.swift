//
//  IconsBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 24/08/2024.
//

import SwiftUI

struct IconsBootcamp: View {
    let color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    var body: some View {
        Image(systemName: "person.fill.badge.plus")
            .renderingMode(.original) //lets me use multi-colors
            .font(.largeTitle)
            //.resizable() //we call it to resize it to our frame
            //.aspectRatio(contentMode: .fit) //.fill
            //.scaledToFit()
            //.scaledToFill()
            //.font(.caption) better option because of resize
            //.font(.system(size: 200))
            //.foregroundColor(Color(color))
            //.frame(width: 300, height: 300)
            //.clipped() //clipped to the frame
    }
}

struct IconsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        IconsBootcamp()
    }
}
