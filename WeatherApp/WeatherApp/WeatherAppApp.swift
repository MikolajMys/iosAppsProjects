//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 07/10/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}
