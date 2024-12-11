//
//  DocumentationBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 02/12/2024.
//

import SwiftUI

struct DocumentationBootcamp: View {
    
    // MARK: PROPERTIES
    
    @State var data: [String] = [
        "Apples", "Oranges", "Bananas"
    ]
    @State var showAlert: Bool = false
    
    // MARK: BODY
      
    // MIKI - Working copy - things to do:
    /*
     1) Fix title
     2) Fix alert
     3) Fix sth
     */
    
    var body: some View {
        NavigationView { // START: NAV
            ZStack {
                // background
                Color.red.ignoresSafeArea()
                
                // foreground
                foregroundLayer
                .navigationTitle("Documentation")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("ALERT") {
                            showAlert.toggle()
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    getAlert(text: "This is the alert!")
                }
            }
        } // END: NAV
    }
    
    /// This is the foreground layer that holds a scrollView
    private var foregroundLayer: some View {
        ScrollView { // START: SCROLLV
            Text("Fruits:")
            ForEach(data, id: \.self) { name in
                Text(name)
                    .font(.headline)
            }
        } // END: SCROLLV
    }
    
    // MARK: FUNCTIONS
    
    /// Gets an alert with a specify title
    ///
    ///  This function creates and returns and alert immediately. The alert will have a title based on the text parameter but it will NOT have message.
    /// ```
    /// getAlert(text: "Hi") -> Alert(title: Text("Hi"))
    /// ```
    ///
    /// - Warning: There is no additional message in this Alert.
    /// - Parameter text: This is the title for the alert
    /// - Returns: Returns an alert with a title
    func getAlert(text: String) -> Alert {
        return Alert(title: Text(text))
    }
}

// MARK: PREVIEW

struct DocumentationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationBootcamp()
    }
}
