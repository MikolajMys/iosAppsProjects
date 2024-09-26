//
//  TextEditorBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 26/09/2024.
//

import SwiftUI

struct TextEditorBootcamp: View {
    
    @State var textEditorContent: String = "This is the starting text."
    @State var savetText: String = ""
    let textEditorColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    
    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $textEditorContent)
                    .frame(height: 250)
                    //.foregroundColor(.red)
                    //.background(Color.red)
                    .colorMultiply(Color(textEditorColor))
                    .cornerRadius(10)
                Button {
                    savetText = textEditorContent
                } label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Text(savetText)
                Spacer()
            }
            .padding()
            //.background(Color.green)
            .navigationTitle("Text Editor Bootcamp!")
        }
    }
}

struct TextEditorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorBootcamp()
    }
}
