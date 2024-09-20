//
//  PopoverBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 20/09/2024.
//


// sheets
// animations
// transitions

import SwiftUI

struct PopoverBootcamp: View {
    
    @State var showNewScreen: Bool = false
    
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            VStack {
                Button("BUTTON") {
                    withAnimation(.spring()){
                        showNewScreen.toggle()
                    }
                }
                .font(.largeTitle)
                Spacer()
            }
            
            // METHOD 1 - SHEET
//            .sheet(isPresented: $showNewScreen) {
//                NewScreen()
//            }
            
            // METHOD 2 - TRANSITION
//            ZStack {
//                if showNewScreen {
//                    NewScreen(showNewScreen: $showNewScreen)
//                        .padding(.top, 50)
//                        .transition(.move(edge: .bottom))
//                        //.animation(.spring()) // using withAnimation() instead
//                }
//            }
//            .zIndex(2.0) // make sure its in the front
            
            // METHOD 3 - ANIMATION OF OFFSET
            NewScreen(showNewScreen: $showNewScreen)
                .padding(.top, 50)
                .offset(y: showNewScreen ? 0 : UIScreen.main.bounds.height)
                //.animation(.spring()) // using withAnimation() instead
        }
    }
}

struct NewScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var showNewScreen: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.purple
                .ignoresSafeArea()
            Button {
                //presentationMode.wrappedValue.dismiss()
                withAnimation(.spring()) {
                    showNewScreen.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            }

        }
    }
}

struct PopoverBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PopoverBootcamp()
    }
}
