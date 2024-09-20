//
//  TernaryBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 08/09/2024.
//

import SwiftUI

struct TernaryBootcamp: View {
    
    @State var isStartingState: Bool = false
    
    var body: some View {
        VStack {
            Button {
                isStartingState.toggle()
            } label: {
                Text("Button: \(isStartingState.description)")
            }
            
            Text(isStartingState ? "STARTING STATE!!!" : "ENDING STATE.")
            
            RoundedRectangle(cornerRadius: isStartingState ? 25 : 0)
                .fill(isStartingState ? Color.red : Color.blue) //ternary statement
                .frame(
                    width: isStartingState ? 200 : 50,
                    height: isStartingState ? 400 : 100
                )
            
            Spacer()
        }
    }
}

struct TernaryBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TernaryBootcamp()
    }
}
