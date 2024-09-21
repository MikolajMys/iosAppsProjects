//
//  AlertBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 21/09/2024.
//

import SwiftUI

struct AlertBootcamp: View {
    
    @State var showAlert: Bool = false
    @State var alertType: MyAlerts? = nil
    //@State var alertTitle: String = ""
    //@State var alertMessage: String = ""
    @State var backgroundColor: Color = Color.yellow
    
    enum MyAlerts {
        case success
        case error
    }
    
    // old version of code
//    var body: some View {
//        ZStack {
//            backgroundColor.ignoresSafeArea()
//
//            Button("Show Alert") {
//                showAlert.toggle()
//            }
//            .alert(isPresented: $showAlert, content: createAlert)
//        }
//    }
//
//    // Custom function to create the alert
//    func createAlert() -> Alert {
//        Alert(
//            title: Text("ERROR!"),
//            message: Text("Error description"),
//            primaryButton: .destructive(Text("Delete")) {
//                backgroundColor = .red
//            },
//            secondaryButton: .cancel {
//                backgroundColor = .yellow
//            }
//        )
//    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            VStack {
                Button("BUTTON 1") {
                    alertType = .error
                    //alertTitle = "ERROR UPLOADING VIDEO"
                    //alertMessage = "The video could not be uploaded!"
                    showAlert.toggle()
                }
                Button("BUTTON 2") {
                    alertType = .success
                    //alertTitle = "Succesfully uploaded video 🥳" // control, command and space buttons
                    //alertMessage = "Your video is now public!"
                    showAlert.toggle()
                }
            }
            // DEFAULT ALERT
//            .alert("There was an error!", isPresented: $showAlert) {
//                // SwiftUI automatycznie doda przycisk "OK"
//            }
            // CUSTOM ALERT
            .alert(getAlertTitle(), isPresented: $showAlert) {
                getAlertActions()
            } message: {
                Text(getAlertMessage())
            }
        }
    }
    func getAlertTitle() -> String {
        switch alertType {
        case .error:
            return "ERROR"
        case .success:
            return "SUCCESS"
        default:
            return "UNKNOWN"
        }
    }
    func getAlertMessage() -> String {
        switch alertType {
        case .error:
            return "video not uploaded"
        case .success:
            return "upload successful"
        default:
            return "sth went wrong"
        }
    }
    func getAlertActions() -> some View {
        Group {
//            Button("Delete", role: .diss) {
//                backgroundColor = .red
//            }
//            Button("Cancel", role: .cancel) {
//                backgroundColor = .yellow
//            }
            Button("OK") {
                if alertType == .success {
                    backgroundColor = .green
                } else if alertType == .error {
                    backgroundColor = .red
                } else {
                    backgroundColor = .white
                }
            }
        }
    }
}

struct AlertBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AlertBootcamp()
    }
}
