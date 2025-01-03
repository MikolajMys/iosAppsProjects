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
    @StateObject private var alertManager = AlertManager()
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
                    .environmentObject(alertManager)
            } else {
                LoginView()
                    .environmentObject(alertManager)
            }
        }
    }
}
