//
//  DefaultWeatherRepository.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

class DefaultWeatherRepository: WeatherRepository, WeatherComRepository {    
    private let weatherAPIClient: WeatherAPIClient
    private let alertsAPIClient: AlertsAPIClient
    
    init(weatherAPIClient: WeatherAPIClient, alertsAPIClient: AlertsAPIClient) {
        self.weatherAPIClient = weatherAPIClient
        self.alertsAPIClient = alertsAPIClient
    }
    
    // MARK: - Weather Repository Implementation
    func fetchCurrentConditions(for location: String, forceRefresh: Bool = false) async throws -> CurrentWeather {
        return try await weatherAPIClient.fetchCurrentWeather(for: location)
    }
    
    func fetchForecast(for location: String) async throws -> [DayForecast] {
        return try await weatherAPIClient.fetchForecast(for: location)
    }
    
    func fetchAirQuality(for location: String) async throws -> AirQuality {
        return try await weatherAPIClient.fetchAirQuality(for: location)
    }
    
    
    // MARK: - Alerts Repository Implementation
    func fetchWeatherAlerts(for location: String) async throws -> [WeatherAlert] {
        return try await alertsAPIClient.fetchAlerts(for: location)
    }
    
    func fetchAstronomyInfo(for location: String) async throws -> AstronomyInfo {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = formatter.string(from: Date())
        return try await alertsAPIClient.fetchAstronomy(for: location, when: currentDateString)
    }
}
