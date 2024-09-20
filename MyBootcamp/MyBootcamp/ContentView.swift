//
//  ContentView.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 22/08/2024.
//

import SwiftUI

struct ContentView: View {
    let shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    let shadowBGColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple, .pink, .orange, .yellow],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white) // Kolor obiektu
                .frame(width: 300, height: 150)
                .overlay(
                    Text("MyBootcamp")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.white) // Tekst musi być przezroczysty
                        .blendMode(.destinationOut) // Efekt "wycięcia"
                )
                .compositingGroup()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
