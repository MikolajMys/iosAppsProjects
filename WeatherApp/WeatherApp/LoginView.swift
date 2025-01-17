//
//  LoginView.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 24/12/2024.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("username") private var storedUsername: String = ""
    @State private var username: String = ""
    @State private var password: String = ""


    var body: some View {
        NavigationView {
            ZStack {
                Color("DetailColor")
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack{
                            Text("Weather App")
                                .font(.title3)
                            Image(systemName: "cloud.sun.rain.fill")
                        }
                    }
                    .frame(width: 300, height: 50)
                    .background(Color("DetailColor").opacity(0.5))
                    .foregroundColor(Color("FontColor"))
                    Spacer()
                    VStack(spacing: 10) {
                        InputView(text: $username, title: "Login", placeholder: "Enter your login")
                        //InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        Spacer()
                        HStack {
                            
//                            VStack(alignment: .leading) {
//                                Text("No account?")
//                                    .font(.caption)
//                                NavigationLink {
//                                    RegisterView()
//                                } label: {
//                                    Text("SIGN UP")
//                                    Image(systemName: "chevron.right")
//                                }
//                                .tint(.white)
//
//                            }.padding(.bottom, 10)

                            
                            Spacer()
                            
                            Button {
                                if !username.isEmpty {
                                    isLoggedIn = true
                                    storedUsername = username
                                }
                            } label: {
                                HStack {
                                    Text("SIGN IN")
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            
                        }
                    }
                    .padding(20)
                }
                .frame(width: 300, height: 300)
                .background(Color("FormColor"))
                .cornerRadius(20)
                .shadow(color: .black, radius: 20, x: 15, y: 15)
                ConnectionStatusView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(NetworkMonitor())
    }
}
