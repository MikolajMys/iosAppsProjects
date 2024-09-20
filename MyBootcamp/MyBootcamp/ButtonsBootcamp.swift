//
//  ButtonsBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 04/09/2024.
//

import SwiftUI

struct ButtonsBootcamp: View {
    
    let color1 = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
    @State var title: String = "This is my title"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
            
            Button("Press me!") {
                self.title = "Button #1 was pressed"
            }
            .accentColor(.red)
            
            Button {
                self.title = "Button #2 was pressed"
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 20)
                    .background(
                        Color.blue
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    )
            }

            Button {
                self.title = "Button #3 was pressed"
            } label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 75, height: 75)
                    .shadow(radius: 10)
                    .overlay {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color(color1))
                    }
            }

            Button {
                self.title = "Button #4 was pressed"
            } label: {
                Text("Finiah".uppercased())
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                    .padding()
                    .padding(.horizontal, 10)
                    .background(
                        Capsule()
                            .stroke(Color.gray, lineWidth: 2.0)
                    )
            }

            
        }
    }
}

struct ButtonsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsBootcamp()
    }
}
