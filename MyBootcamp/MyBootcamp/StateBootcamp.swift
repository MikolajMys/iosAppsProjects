//
//  StateBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 04/09/2024.
//

import SwiftUI

struct StateBootcamp: View {
    
    @State var backgroundColor: Color = Color.green
    @State var myTitle: String = "My Title"
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            // background
            backgroundColor
                //.edgesIgnoringSafeArea(.all)
                .ignoresSafeArea()
            
            // content
            VStack(spacing: 20) {
                Text(myTitle)
                    .font(.title)
                Text("Count: \(count)")
                    .font(.headline)
                    .underline()
                
                HStack(spacing: 20) {
                    Button("Button 1") {
                        backgroundColor = .red
                        myTitle = "Button 1 was pressed"
                        count = count + 1
                    }
                    
                    Button {
                        self.backgroundColor = .purple
                        self.myTitle = "Button 2 was pressed"
                        count -= 1
                    } label: {
                        Text("Button 2")
                    }

                }
            }
            .foregroundColor(.white)
        }
    }
}

struct StateBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StateBootcamp()
    }
}
