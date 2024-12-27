import SwiftUI
import MapKit

struct MainView: View {
    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        ZStack {
            MapView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)

            if let pinToConfirm = viewModel.pinToConfirm {
                ConfirmPinView(coordinate: pinToConfirm.coordinate, onConfirm: {
                    viewModel.addPin(pinToConfirm)
                }, onCancel: {
                    viewModel.pinToConfirm = nil
                })
            }
        }
    }
}

struct MapView: UIViewRepresentable {
    @ObservedObject var viewModel: MapViewModel

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // Wyłącz domyślne działanie gestów mapy dla podwójnego kliknięcia
        mapView.gestureRecognizers?.forEach { gestureRecognizer in
            if let tapGesture = gestureRecognizer as? UITapGestureRecognizer, tapGesture.numberOfTapsRequired == 2 {
                tapGesture.isEnabled = false
            }
        }

        let doubleTapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTapGesture)

        return mapView
    }


    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(viewModel.pins)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var viewModel: MapViewModel

        init(viewModel: MapViewModel) {
            self.viewModel = viewModel
        }

        @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
            guard let mapView = gesture.view as? MKMapView else { return }
            let location = gesture.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

            // Propose a pin at the double-tap location
            let newPin = CustomPin(title: "Confirm Pin", subtitle: "Add this pin?", coordinate: coordinate)
            viewModel.pinToConfirm = newPin
        }
    }
}

final class MapViewModel: NSObject, ObservableObject {
    @Published var pins: [CustomPin] = []
    @Published var pinToConfirm: CustomPin?

    func addPin(_ pin: CustomPin) {
        pins.append(pin)
        pinToConfirm = nil
    }
}

class CustomPin: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

struct ConfirmPinView: View {
    let coordinate: CLLocationCoordinate2D
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Confirm Pin")
                    .font(.headline)
                Text("Lat: \(coordinate.latitude), Lon: \(coordinate.longitude)")
                    .font(.subheadline)

                HStack {
                    Button("Add") {
                        onConfirm()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("Cancel") {
                        onCancel()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.bottom, 50)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
