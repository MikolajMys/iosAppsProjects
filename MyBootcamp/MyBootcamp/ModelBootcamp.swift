//
//  ModelBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 16/12/2024.
//

import SwiftUI

struct UserModel: Identifiable {
    let id: String = UUID().uuidString //random string id
    let displayName: String
    let userName: String
    let followerCout: Int
    let isVerified: Bool
}

struct ModelBootcamp: View {
    
    @State var users: [UserModel] = [
        //"Miki", "Emily", "Samantha", "Chris"
        UserModel(displayName: "Miki", userName: "miki123", followerCout: 100, isVerified: true),
        UserModel(displayName: "Emily", userName: "itsemily1995", followerCout: 55, isVerified: false),
        UserModel(displayName: "Samantha", userName: "ninja", followerCout: 355, isVerified: false),
        UserModel(displayName: "Chris", userName: "chrish2009", followerCout: 88, isVerified: true)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    HStack(spacing: 15.0) {
                        Circle()
                            .frame(width: 35, height: 35)
                        VStack(alignment: .leading) {
                            Text(user.displayName)
                                .font(.headline)
                            Text("@\(user.userName)")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        Spacer()
                        
                        if user.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                        }
                        
                        VStack {
                            Text("\(user.followerCout)")
                                .font(.headline)
                            Text("Followers")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Users")
        }
    }
}

struct ModelBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ModelBootcamp()
    }
}
