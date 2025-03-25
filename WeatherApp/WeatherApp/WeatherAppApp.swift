//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 07/10/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
//    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
//    @StateObject private var alertManager = AlertManager()
//    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            MapTileOverlay()
        }
    }
}
