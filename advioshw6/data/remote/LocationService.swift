//
//  LocationService.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//

import CoreLocation

protocol LocationService {
    func getCoordinates(for location: String) async throws -> CLLocationCoordinate2D
}

class CoreLocationService: LocationService {
    func getCoordinates(for location: String) async throws -> CLLocationCoordinate2D {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(location)
        
        guard let coordinate = placemarks.first?.location?.coordinate else {
            throw WeatherError.invalidLocation
        }
        
        return coordinate
    }
}
