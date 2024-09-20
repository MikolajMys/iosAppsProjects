//
//  ColorsBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 23/08/2024.
//

import SwiftUI

struct ColorsBootcamp: View {
    var color = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(
                //Color.primary
                //Color(color) //color literal didn't work directly, needed to use '='
                //Color(UIColor.secondarySystemBackground)
                Color("CustomColor")
            )
            .frame(width: 300, height: 200)
            //.shadow(radius: 10)
            .shadow(color: Color("CustomColor").opacity(0.5), radius: 10, x: -10, y: -10)
    }
}

struct ColorsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ColorsBootcamp()
    }
}
