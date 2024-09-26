//
//  TextFieldBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 26/09/2024.
//

import SwiftUI

struct TextFieldBootcamp: View {
    
    @State var textFieldContent: String = ""
    @State var dataArray: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type something here...", text: $textFieldContent)
                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.red)
                    .font(.headline)
                Button {
                    saveText(content: textFieldContent)
                } label: {
                    Text("Save".uppercased())
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(textChecker(content: textFieldContent) ? Color.blue : Color.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .disabled(!textChecker(content: textFieldContent))
                
                ForEach(dataArray, id: \.self) { data in
                    Text(data)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Text Field Bootcamp!")
        }
    }
    func textChecker(content: String) -> Bool {
        if content.count >= 3 {
            return true
        }
        return false
    }
    
    func saveText(content: String) {
        if textChecker(content: content) {
            dataArray.append(content)
            textFieldContent = ""
        }
    }
}

struct TextFieldBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldBootcamp()
    }
}
