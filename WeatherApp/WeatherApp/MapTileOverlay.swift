//
//  MapTileOverlay.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 25/03/2025.
//

import SwiftUI
import MapKit

struct MapTileOverlay: UIViewRepresentable {
    let mapView = MKMapView()
    @State private var userLocation: CLLocationCoordinate2D? = nil // To store the current user location

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        
        // Request user location permission
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        // Ścieżka do MBTiles
        if let filePath = Bundle.main.path(forResource: "Unnamed atlas", ofType: "mbtiles"),
           let overlay = MBTilesOverlay(mbtilesPath: filePath) {
            overlay.canReplaceMapContent = true
            mapView.addOverlay(overlay)
        }

        // Add button to drop pin at user location
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: 20, width: 100, height: 40)
        button.setTitle("Add Pin", for: .normal)
        button.addTarget(context.coordinator, action: #selector(Coordinator.addPin), for: .touchUpInside)
        
        // Add button to the map view
        mapView.addSubview(button)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // If the location changes, update the pin position
        if let userLocation = userLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = "Your Location"
            uiView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapTileOverlay

        init(_ parent: MapTileOverlay) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let tileOverlay = overlay as? MKTileOverlay {
                return MKTileOverlayRenderer(tileOverlay: tileOverlay)
            }
            return MKOverlayRenderer()
        }

        // Action to add pin at user location
        @objc func addPin() {
            if let userLocation = parent.mapView.userLocation.location?.coordinate {
                let annotation = MKPointAnnotation()
                annotation.coordinate = userLocation
                annotation.title = "Your Location"
                parent.mapView.addAnnotation(annotation)
            }
        }
    }
}
