//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 07/10/2024.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("username") private var storedUsername: String = ""
    @StateObject private var locationManager = LocationManager()
    @State private var weatherData: WeatherData?
    @State private var cityName: String = ""
    @State private var alertMessage: String = ""
    @State private var citySearching: Bool = false
    @State private var showAlert = false
    @State private var showMapView = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("DetailColor")
                    .ignoresSafeArea()
                VStack {
                    if let weatherData = weatherData {
                        HStack {
                            TextField("", text: $cityName, prompt: Text("Enter city name...").foregroundColor(Color("FontColor")))
                                .frame(width: 150)
                            Button {
                                if !cityName.isEmpty {
                                    citySearching = true
                                    fetchWeatherData(for: cityName)
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                            }
                            Spacer()
                            Button {
                                if cityName.isEmpty {
                                    locationManager.requestLocation()
                                } else {
                                    alertMessage = "Unable to get location while using city name search!"
                                    showAlert = true
                                }
                            } label: {
                                Image(systemName: "location.circle")
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            Button {
                                isLoggedIn = false
                            } label: {
                                Image(systemName: "figure.walk.arrival")
                                    .environment(\.layoutDirection, .rightToLeft)
                                    .foregroundColor(.red)
                            }

                        }
                        .padding(.horizontal, 20)
                        .frame(width: 300, height: 50)
                        .background(Color("DetailColor").opacity(0.5))
                        .alert("Unable to Proceed", isPresented: $showAlert) {
                            Button("OK", role: .cancel) {}
                        } message: {
                            Text(alertMessage)
                        }
                        Spacer()
                        Text(String(format: "%.1f°C", weatherData.main.temp))
                            .font(.custom("", size: 70))
                        Spacer()
                        VStack(alignment: .leading) {
                            HStack {
                                NavigationLink(
                                    destination: MapView(
                                        latitude: weatherData.coord.lat,
                                        longitude: weatherData.coord.lon,
                                        temperature: String(format: "%.1f°C", weatherData.main.temp)
                                    ),
                                    isActive: $showMapView
                                ) {
                                    Image(systemName: "location.circle.fill")
                                        .onTapGesture {
                                            showMapView = true
                                        }
                                }
                                Text("\(weatherData.sys.country)")
                            }
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                Text("\(weatherData.name)")
                            }
                            HStack {
                                Image(systemName: "pencil.circle.fill")
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
                .background(Color("FormColor"))
                .foregroundColor(Color("FontColor"))
                .cornerRadius(20)
                .shadow(color: .black, radius: 20, x: 15, y: 15)
                .onAppear {
                    locationManager.requestLocation()
                }
                .onReceive(locationManager.$location) { location in
                    guard let location = location else { return }
                    fetchWeatherData(for: location)
                }
            }
            .navigationTitle("Welcome, \(storedUsername)")
        }
    }

    private func fetchWeatherData(for cityName: String) {
        let apiKey = "YOUR_API_KEY"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }

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

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }

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
