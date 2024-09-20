//
//  NavigationViewBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 20/09/2024.
//

import SwiftUI

struct NavigationViewBootcamp: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
                NavigationLink("Hello, world!") {
                    MyOtherScreen()
                }
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("All Inboxes")
            //.navigationBarTitleDisplayMode(.automatic)
            //.navigationBarHidden(true) // old way of making navbar dissapear
            //.toolbar(.hidden, for: .navigationBar)
//            .navigationBarItems( // old code
//                leading: Image(systemName: "person.fill"),
//                trailing: Image(systemName: "gear")
//            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "person.fill")
                        Image(systemName: "flame.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MyOtherScreen()) {
                        Image(systemName: "gear")
                            //.foregroundColor(.red) // alternative color icon change
                    }
                    //.accentColor(Color.red) //old code
                    .tint(.red)
                }
            }
        }
    }
}

struct MyOtherScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
                .navigationTitle("Green Screen!")
                //.toolbar(.hidden, for: .navigationBar)
            
            VStack {
                HStack {
                    Button("< BACK BUTTON") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
                NavigationLink("Click here") {
                    Text("3rd screen!")
                }
                Spacer()
            }
        }
    }
}

struct NavigationViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewBootcamp()
    }
}
