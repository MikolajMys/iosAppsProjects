//
//  ToggleBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 28/09/2024.
//

import SwiftUI

struct ToggleBootcamp: View {
    
    @State var toggleIsOn: Bool = false
    let toggleColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
        VStack {
            HStack {
                Text("Status:")
                Text(toggleIsOn ? "Online" : "Offline")
            }
            .font(.title)
            Toggle(isOn: $toggleIsOn) {
                Text("Label")
            }
            .toggleStyle(SwitchToggleStyle(tint: Color(toggleColor)))
            
            Spacer()
        }
        .padding(.horizontal, 100)
    }
}

struct ToggleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ToggleBootcamp()
    }
}
