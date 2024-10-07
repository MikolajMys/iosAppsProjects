//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 07/10/2024.
//

import Foundation
import CoreLocation

struct WeatherData: Codable {
    let name: String
    let sys: Sys
    let main: Main
    let weather: [Weather]
}
struct Sys: Codable {
    let country: String
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
        print("Updated location: \(location.coordinate.latitude), \(location.coordinate.longitude)") // Check updated location
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
