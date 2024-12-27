//
//  InputView.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 25/12/2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if !title.isEmpty {
                Text(title)
            }
            if isSecureField {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(Color("FontColor").opacity(0.5)))
                    .disableAutocorrection(true)
            } else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundColor(Color("FontColor").opacity(0.5)))
                    .disableAutocorrection(true)
            }
            Divider()
                .background(Color("FontColor"))
        }
        .foregroundColor(Color("FontColor"))
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Name", placeholder: "John")
    }
}
