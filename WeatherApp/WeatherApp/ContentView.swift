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
    @State private var cityName: String = ""
    @State private var citySearching: Bool = false
    
    let detailColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    
    var body: some View {
        ZStack {
            Color(detailColor)
                .ignoresSafeArea()
            VStack {
                if let weatherData = weatherData {
                    HStack{
                        TextField("", text: $cityName, prompt: Text("Enter city name...").foregroundColor(.black))
                            .frame(width: 150)
                            .tint(.black)
                        Button {
                            if !cityName.isEmpty {
                                citySearching = true
                                fetchWeatherData(for: cityName)
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .tint(.black)
                        }
                        Spacer()
                        Button {
                            if cityName.isEmpty {
                                locationManager.requestLocation()
                            }
                        } label: {
                            Image(systemName: "gobackward")
                                .tint(.black)
                        }
                    }
                    .padding(20)
                    .background(Color(detailColor).opacity(0.5))
                    Spacer()
                    Text(String(format: "%.1f°C", weatherData.main.temp))
                        .font(.custom("", size: 70))
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location.circle.fill")
                                .tint(.black)
                            Text("\(weatherData.sys.country)")
                        }
                        HStack {
                            Image(systemName: "mappin.circle.fill")
                                .tint(.black)
                            Text("\(weatherData.name)")
                        }
                        HStack {
                            Image(systemName: "pencil.circle.fill")
                                .tint(.black)
                            Text("\(weatherData.weather.first?.description ?? "")")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .font(.title)
                    Spacer()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 300, height: 300)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(color: .black, radius: 20, x: 15, y: 15)
            //.padding()
            .onAppear {
                locationManager.requestLocation()
            }
            .onReceive(locationManager.$location) { location in
                guard let location = location else {return}
                fetchWeatherData(for: location)
            }
        }
    }
    
    private func fetchWeatherData(for cityName: String) {
        let apiKey = "YOUR_API_KEY"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherData.self, from: data)
                
                DispatchQueue.main.async {
                    self.weatherData = weatherResponse
                    self.cityName = ""
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
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
