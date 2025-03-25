//
//  MapOffline.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 25/03/2025.
//
import SwiftUI
import MapKit

struct LocationAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapPolyline: Identifiable {
    let polyline: MKPolyline
    let id = UUID()
    
    init(coordinates: [CLLocationCoordinate2D]) {
        polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

struct MapViewWrapper: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var pins: [LocationAnnotation]
    @Binding var polylines: [MapPolyline]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
        
        // Update annotations
        let currentAnnotations = mapView.annotations.compactMap { $0 as? MKPointAnnotation }
        mapView.removeAnnotations(currentAnnotations)
        
        let newAnnotations = pins.map { pin -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = pin.coordinate
            return annotation
        }
        mapView.addAnnotations(newAnnotations)
        
        // Update overlays
        mapView.removeOverlays(mapView.overlays)
        polylines.forEach { mapView.addOverlay($0.polyline) }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator()
    }
}

struct MapOffline: View {
    @Environment(\.dismiss) var dismiss
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.2298, longitude: 21.0118),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var pins: [LocationAnnotation] = []
    @State private var polylines: [MapPolyline] = []
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            MapViewWrapper(region: $region, pins: $pins, polylines: $polylines)
                .ignoresSafeArea()
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .sequenced(before: DragGesture(minimumDistance: 0))
                        .onEnded { value in
                            if case .second(true, let drag?) = value {
                                let coordinate = region.centerFrom(location: drag.location)
                                addPin(at: coordinate)
                            }
                        }
                )
            
            VStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button(action: centerOnUserLocation) {
                    Image(systemName: "location.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .padding()
                }
                
                Button(action: addCurrentLocationPin) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.purple)
                        .padding()
                }
                
                if pins.count > 1 {
                    Button(action: drawBoundary) {
                        Image(systemName: "map.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                            .padding()
                    }
                }
            }
        }
    }
    
    private func addPin(at coordinate: CLLocationCoordinate2D) {
        let newPin = LocationAnnotation(coordinate: coordinate)
        pins.append(newPin)
    }
    
    private func addCurrentLocationPin() {
        if let location = locationManager.location?.coordinate {
            addPin(at: location)
            region.center = location
        }
    }
    
    private func centerOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            region.center = location
        }
    }
    
    private func drawBoundary() {
        guard pins.count > 1 else { return }
        
        var coordinates = pins.map { $0.coordinate }
        coordinates.append(coordinates.first!)
        polylines = [MapPolyline(coordinates: coordinates)]
    }
}

class OfflineLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}

extension MKCoordinateRegion {
    func centerFrom(location: CGPoint) -> CLLocationCoordinate2D {
        let centerMapPoint = MKMapPoint(center)
        let span = self.span
        
        return CLLocationCoordinate2D(
            latitude: center.latitude - (span.latitudeDelta * Double(location.y / 500 - 0.5)),
            longitude: center.longitude + (span.longitudeDelta * Double(location.x / 500 - 0.5))
        )
    }
}

struct OfflineContentView: View {
    @State private var showMap = false
    
    var body: some View {
        VStack {
            Button("Open Map") {
                showMap = true
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showMap) {
            MapOffline()
        }
    }
}
