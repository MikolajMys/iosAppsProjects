//
//  NetworkMonitor.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 04/01/2025.
//

import Foundation
import Network
import SwiftUI

final class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool = true
    @Published var shouldRefreshMapView: Bool = false
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let wasConnected = self?.isConnected ?? true
                self?.isConnected = (path.status == .satisfied)
                
                // Jeśli stan połączenia zmienił się z offline na online, wywołaj odświeżenie MapView
                if wasConnected == false && self?.isConnected == true {
                    self?.shouldRefreshMapView = true
                }
            }
        }
        monitor.start(queue: queue)
    }
}
