//
//  ApiClients.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//

import SwiftUI

protocol WeatherAPIClient {
    func fetchCurrentWeather(for location: String) async throws -> CurrentWeather
    func fetchForecast(for location: String) async throws -> [DayForecast]
    func fetchAirQuality(for location: String) async throws -> AirQuality
}

protocol AlertsAPIClient {
    func fetchAlerts(for location: String) async throws -> [WeatherAlert]
    func fetchAstronomy(for location: String, when date: String) async throws -> AstronomyInfo
}
