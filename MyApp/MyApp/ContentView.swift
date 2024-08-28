//
//  ContentView.swift
//  MyApp
//
//  Created by Mikołaj Myśliński on 29/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Solve this cube!")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black, radius: 4, x: 5, y: 5)
                .padding(.bottom, 50)
            HStack {
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("1")
                                .foregroundColor(.white)
                        )
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("4")
                                .foregroundColor(.white)
                        )
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("7")
                                .foregroundColor(.white)
                        )
                }
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("2")
                                .foregroundColor(.white)
                        )
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("5")
                                .foregroundColor(.white)
                        )
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("8")
                                .foregroundColor(.white)
                        )
                    
                }
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("3")
                                .foregroundColor(.white)
                        )
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("6")
                                .foregroundColor(.white)
                        )
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.all, 10)
            .background(Color.black.opacity(0.6))
        .shadow(color: .black, radius: 10, x: 5, y: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
