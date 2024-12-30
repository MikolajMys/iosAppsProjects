import SwiftUI
import MapKit

struct MapView: View {
    
    let latitude: Double
    let longitude: Double
    let temperature: String
    
    @State private var region: MKCoordinateRegion
    @State private var selectedTemperature: String? = nil
    @State private var showingAnnotation: Bool = false

    init(latitude: Double, longitude: Double, temperature: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.temperature = temperature
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        ))
    }

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: [MapPin(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))]) { pin in
                MapAnnotation(coordinate: pin.coordinate) {
                    Button {
                        DispatchQueue.main.async {
                            selectedTemperature = temperature
                            showingAnnotation.toggle()
                        }
                    } label: {
                        VStack {
                            Image(systemName: "cloud.sun.rain.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                                .background(Color.white)
                                .cornerRadius(20)
                            Text("Tap me!")
                                .font(.caption)
                                .foregroundColor(Color("FontColor"))
                        }
                    }
                }
                
            }
            .ignoresSafeArea()
            
            if showingAnnotation, let selectedTemperature = selectedTemperature {
                VStack {
                    ZStack {
                        Image(systemName: "cloud.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundColor(Color("DetailColor"))
                        HStack {
                            Image(systemName: "thermometer.medium")
                            Text(selectedTemperature)
                        }
                        .foregroundColor(Color("FontColor"))
                        .font(.headline)
                        .padding(.top, 15)
                    }
                    Spacer()
                }
            }
        }
        .onTapGesture {
            showingAnnotation = false
        }
    }
}

struct MapPin: Identifiable {
    let id: String = UUID().uuidString
    let coordinate: CLLocationCoordinate2D
}
