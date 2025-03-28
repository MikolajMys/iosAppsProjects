//
//  MKMapView.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 26/03/2025.
//

//import Foundation
//import SwiftUI
//import MapKit
//
//struct MapView: UIViewRepresentable {
//    @ObservedObject var viewModel: MapViewModel
//    let mbTilesPath = Bundle.main.path(forResource: "map", ofType: "mbtiles")
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.mapType = .standard // Systemowe mapy jako tło
//
//        if viewModel.isOffline, let mbTilesPath = mbTilesPath {
//            let overlay = MBTilesOverlay(mbtilesPath: mbTilesPath)
//            mapView.addOverlay(overlay!, level: .aboveLabels)
//        }
//
//        return mapView
//    }
//
//    func updateUIView(_ mapView: MKMapView, context: Context) {
//        if viewModel.isOffline, let mbTilesPath = mbTilesPath {
//            let overlay = MBTilesOverlay(mbtilesPath: mbTilesPath)
//            mapView.addOverlay(overlay!, level: .aboveLabels)
//        } else {
//            mapView.removeOverlays(mapView.overlays)
//        }
//    }
//}
