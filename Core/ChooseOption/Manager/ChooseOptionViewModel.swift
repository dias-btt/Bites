//
//  ChooseOptionViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 09.05.2024.
import CoreLocation
import MapKit
import SwiftUI

final class ChooseOptionViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?

    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.14827, longitude: 71.459456), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    override init() {
        super.init()
        setupLocationManager()
    }

    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        checkIfLocationIsEnabled()
    }

    func checkIfLocationIsEnabled() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location services are disabled.")
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager?.startUpdatingLocation()
        @unknown default:
            fatalError("Unhandled authorization status.")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkIfLocationIsEnabled()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.mapRegion = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }
    }

    func navigateToUserLocation() {
        if let userLocation = locationManager?.location?.coordinate {
            mapRegion = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
    }
    
    func setMapRegionToShowCafe(cafeAddress: CafeAddress?) {
        guard let cafeAddress = cafeAddress else { return }
        let region = MKCoordinateRegion(center: cafeAddress.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapRegion = region
    }
}
