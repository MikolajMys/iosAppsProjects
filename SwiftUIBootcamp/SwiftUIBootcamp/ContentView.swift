//
//  ContentView.swift
//  SwiftUIBootcamp
//
//  Created by Mikołaj Myśliński on 20/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "xmark")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Initial commit")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
