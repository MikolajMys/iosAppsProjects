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
    @State private var userLocation: CLLocationCoordinate2D? = nil

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        
        // 1. Wyłącz wszystkie domyślne elementy
        mapView.pointOfInterestFilter = .excludingAll
        mapView.showsBuildings = false
        mapView.showsTraffic = false
        
        // 2. Styl mapy - najważniejsze dla ukrycia nazw ulic
        if #available(iOS 16.0, *) {
            let config = MKStandardMapConfiguration()
            config.pointOfInterestFilter = .excludingAll
            config.emphasisStyle = .muted
            mapView.preferredConfiguration = config
        } else {
            mapView.mapType = .mutedStandard
        }
        
        // 3. Dodaj swoje kafelki
        if let filePath = Bundle.main.path(forResource: "planet_22.5224,51.1853_22.5971,51.2177", ofType: "mbtiles"),
           let overlay = MBTilesOverlay(mbtilesPath: filePath) {
            overlay.canReplaceMapContent = true
            mapView.addOverlay(overlay, level: .aboveLabels) // Kluczowe!
        }
        
        // 4. Konfiguracja lokalizacji użytkownika
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        // 5. Przycisk do dodawania pinów (pozostaje bez zmian)
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: 20, width: 100, height: 40)
        button.setTitle("Add Pin", for: .normal)
        button.addTarget(context.coordinator, action: #selector(Coordinator.addPin), for: .touchUpInside)
        mapView.addSubview(button)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
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
        private var annotations: [MKPointAnnotation] = []
        private var polyline: MKPolyline?

        init(_ parent: MapTileOverlay) {
            self.parent = parent
            super.init()
            
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            longPress.minimumPressDuration = 0.5
            parent.mapView.addGestureRecognizer(longPress)
        }

        @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                let point = gesture.location(in: parent.mapView)
                let coordinate = parent.mapView.convert(point, toCoordinateFrom: parent.mapView)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "Pin \(annotations.count + 1)"
                parent.mapView.addAnnotation(annotation)
                annotations.append(annotation)
                
                updatePolyline()
            }
        }
        
        private func updatePolyline() {
            if let existingPolyline = polyline {
                parent.mapView.removeOverlay(existingPolyline)
            }
            
            if annotations.count >= 2 {
                let coordinates = annotations.map { $0.coordinate }
                polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                parent.mapView.addOverlay(polyline!)
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let tileOverlay = overlay as? MKTileOverlay {
                let renderer = MKTileOverlayRenderer(tileOverlay: tileOverlay)
                return renderer
            } else if let routePolyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: routePolyline)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }

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
