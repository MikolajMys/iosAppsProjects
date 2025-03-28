//
//  MapTileOverlay.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 25/03/2025.
//

//import SwiftUI
//import MapKit
//
//struct MapTileOverlay: UIViewRepresentable {
//    @ObservedObject var viewModel: MapViewModel
//    let mbTilesPath = Bundle.main.path(forResource: "Unnamed atlas", ofType: "mbtiles")
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.mapType = .standard // Domyślnie używa map systemowych
//        context.coordinator.mapView = mapView
//        return mapView
//    }
//
//    func updateUIView(_ mapView: MKMapView, context: Context) {
//        if viewModel.isOffline {
//            print("OFFLINE!!")
//            if let mbTilesPath = mbTilesPath, context.coordinator.mbTilesOverlay == nil {
//                let overlay = MBTilesOverlay(mbtilesPath: mbTilesPath)
//                if let overlay = overlay {
//                    context.coordinator.mbTilesOverlay = overlay
//                    mapView.addOverlay(overlay, level: .aboveLabels)
//                }
//            }
//        } else {
//            if let mbTilesPath = mbTilesPath, context.coordinator.mbTilesOverlay == nil {
//                let overlay = MBTilesOverlay(mbtilesPath: mbTilesPath)
//                if let overlay = overlay {
//                    context.coordinator.mbTilesOverlay = overlay
//                    mapView.addOverlay(overlay, level: .aboveLabels)
//                }
//            }
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var mapView: MKMapView?
//        var mbTilesOverlay: MBTilesOverlay?
//    }
//}

import SwiftUI
import MapKit

struct MapTileOverlay: UIViewRepresentable {
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @ObservedObject var viewModel: MapViewModel
    let mapView = MKMapView()
    @State private var userLocation: CLLocationCoordinate2D? = nil

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        
        // 1. Disable default elements (optional customization)
        mapView.pointOfInterestFilter = .excludingAll
        mapView.showsBuildings = false
        mapView.showsTraffic = false
        
        // 2. Style the map to mute street names (if needed)
        if #available(iOS 16.0, *) {
            let config = MKStandardMapConfiguration()
            config.pointOfInterestFilter = .excludingAll
            config.emphasisStyle = .muted
            mapView.preferredConfiguration = config
        } else {
            mapView.mapType = .mutedStandard
        }
        
        // 3. Configure tiles based on online/offline state
        updateMapTiles()

        // 4. Configure user location tracking
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        // 5. Add button for adding pins
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: 20, width: 100, height: 40)
        button.setTitle("Add Pin", for: .normal)
        button.addTarget(context.coordinator, action: #selector(Coordinator.addPin), for: .touchUpInside)
        mapView.addSubview(button)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // If you want to display the user's location on the map
        if let userLocation = userLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = "Your Location"
            uiView.addAnnotation(annotation)
        }

        // Handle online/offline map state change
        updateMapTiles()
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    private func updateMapTiles() {
        if !networkMonitor.isConnected {
            print("Offline mode")
            mapView.reloadInputViews()
            // Add MBTiles overlay for offline use
            if let filePath = Bundle.main.path(forResource: "Unnamed atlas", ofType: "mbtiles"),
               let overlay = MBTilesOverlay(mbtilesPath: filePath) {
                overlay.canReplaceMapContent = true
                mapView.addOverlay(overlay, level: .aboveLabels)
            }
            // Remove system map if previously added
            mapView.mapType = .mutedStandard
        } else {
            print("Online mode")
            mapView.reloadInputViews()
            // Remove MBTiles overlay if in online mode
            mapView.removeOverlays(mapView.overlays.filter { $0 is MKTileOverlay })
            
            mapView.reloadInputViews()
            // Use the system map tiles
            if #available(iOS 16.0, *) {
                let standardConfig = MKStandardMapConfiguration()
                standardConfig.pointOfInterestFilter = .excludingAll
                mapView.preferredConfiguration = standardConfig
            } else {
                mapView.mapType = .standard
            }
        }
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
