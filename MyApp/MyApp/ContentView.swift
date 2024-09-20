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
                    ForEach(1 ..< 4) { item in
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Text("\(item)")
                                        .foregroundColor(.white)
                                )
                        }
                    }
                }
                VStack {
                    ForEach(4 ..< 7) { item in
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Text("\(item)")
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    
                }
                VStack {
                    ForEach(7 ..< 9) { item in
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Text("\(item)")
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.all, 10)
            .background(Color.black.opacity(0.6))
            .cornerRadius(10)//test
        .shadow(color: .black, radius: 10, x: 5, y: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
