//
//  ActionSheetBootcamp.swift - old
//  Confirmation Dialog - new
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 22/09/2024.
//

import SwiftUI

struct ActionSheetBootcamp: View {
    
    @State var showDialog: Bool = false
    @State var backgroundColor: Color = Color.primary
    @State var postOption: DialogPostOptions = .isOtherPost
    
    enum DialogPostOptions {
        case isMyPost
        case isOtherPost
    }
    
    let  myButtonsArray: [(title: String, role: ButtonRole?)] = [
        ("Delete", .destructive),
        ("Report", .destructive),
        ("Share", .none),
        ("Cancel", .cancel)
    ]
    
    let  otherButtonsArray: [(title: String, role: ButtonRole?)] = [
        //("Delete", .destructive),
        ("Report", .destructive),
        ("Share", .none),
        ("Cancel", .cancel)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                Text("@username")
                Spacer()
                Button {
                    postOption = .isMyPost
                    showDialog.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                }
                .tint(.primary)
            }
            .padding(.horizontal)
            
            Rectangle()
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(backgroundColor) // should be rectangle color
        }
//            backgroundColor.ignoresSafeArea()
//            Button("Click me") {
//                showDialog.toggle()
//            }
//            .foregroundColor(.white)
//            .padding(10)
//            .background(Color.blue)
//            .cornerRadius(20)
            // Old code
//            .actionSheet(isPresented: $showDialog) {
//                ActionSheet(title: Text("This is the title!"))
//            }
        .confirmationDialog(
            "This is the title",
            isPresented: $showDialog,
            titleVisibility: .visible,
            actions: getDialogActions,
            message: getDialogMessage
        )
    }
    func getDialogMessage() -> Text {
        Text("This is the message")
    }
    func getDialogActions() -> some View {
        Group {
//            ForEach(buttonsArray, id: \.title) { button in
//                Button(button.title, role: button.role) {
//                    //getButtonRole(title: button.title)
//                }
//            }
            switch postOption {
            case .isOtherPost:
                ForEach(otherButtonsArray, id: \.title) { button in
                    Button(button.title, role: button.role) {
                        getButtonRole(title: button.title)
                    }
                }
            case .isMyPost:
                ForEach(myButtonsArray, id: \.title) { button in
                    Button(button.title, role: button.role) {
                        getButtonRole(title: button.title)
                    }
                }
            }
        }
    }
    func getButtonRole(title: String) {
        switch title {
        case "Delete":
            backgroundColor = .red
        case "Report":
            backgroundColor = .green
        case "Share":
            backgroundColor = .yellow
        case "Cancel":
            backgroundColor = .primary
        default:
            backgroundColor = .primary
        }
    }
}

struct ActionSheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetBootcamp()
    }
}
