//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 07/10/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()
    @StateObject private var viewModel = MapViewModel()
    @State private var isViewActive = true
    
    var body: some Scene {
        WindowGroup {
            if isViewActive {
                MapTileOverlay(viewModel: viewModel)
                    .environmentObject(networkMonitor)
                    .onChange(of: networkMonitor.shouldRefreshMapView) {
                        if !networkMonitor.isConnected {
                            isViewActive = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isViewActive = true
                            }
                        }
                    }
            }
        }
    }
}
