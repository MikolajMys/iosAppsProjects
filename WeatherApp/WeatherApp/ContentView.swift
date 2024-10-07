//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 07/10/2024.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var weatherData: WeatherData?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.black.opacity(0.8))
                .frame(width: 300, height: 300)
            VStack {
                if let weatherData = weatherData {
                    Text("Country: \(weatherData.sys.country)")
                    Text("City: \(weatherData.name)")
//                    Text("Temperature: \(weatherData.main.temp)°C")
                    Text(String(format: "%.1f°C", weatherData.main.temp))
                    Text("Description: \(weatherData.weather.first?.description ?? "")")
                }
            }
            .foregroundColor(.white)
            .font(.headline)
        }
        //.padding()
        .onAppear {
            locationManager.requestLocation()
        }
        .onReceive(locationManager.$location) { newLocation in
            if let location = newLocation {
                fetchWeatherData(for: location)
            }
        }
    }
    
    private func fetchWeatherData(for location: CLLocation) {
        let apiKey = "YOUR_API_KEY"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherData.self, from: data)
                
                DispatchQueue.main.async {
                    self.weatherData = weatherResponse
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
