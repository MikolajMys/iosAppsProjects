//
//  MKMapView-ViewModel.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 26/03/2025.
//

import MapKit
import Network

class MapViewModel: ObservableObject {
    @Published var isOffline = false
    private let monitor = NWPathMonitor()
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isOffline = (path.status != .satisfied)
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
