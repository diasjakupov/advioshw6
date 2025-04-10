//
//  DefaultApiClients.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//


import SwiftUI

class OpenWeatherMapClient: WeatherAPIClient {
    private let networkService: NetworkService
    private let locationService: LocationService
    
    init(networkService: NetworkService, locationService: LocationService) {
        self.networkService = networkService
        self.locationService = locationService
    }
    
    func fetchCurrentWeather(for location: String) async throws -> CurrentWeather {
        let endpoint = "\(APIConfig.OpenWeatherMap.baseURL)/weather?q=\(location)&appid=\(APIConfig.OpenWeatherMap.apiKey)"
        
        let response: OpenWeatherMapResponse = try await networkService.fetch(from: endpoint)
        
        return CurrentWeather(
            temperature: kelvinToCelsius(response.main.temp),
            condition: response.weather.first?.description.capitalized ?? "Unknown",
            icon: response.weather.first?.icon ?? "",
            highTemp: kelvinToCelsius(response.main.temp_max),
            lowTemp: kelvinToCelsius(response.main.temp_min),
            feelsLike: kelvinToCelsius(response.main.feels_like),
            windSpeed: Int(response.wind.speed),
            humidity: response.main.humidity
        )
    }
    
    func fetchForecast(for location: String) async throws -> [DayForecast] {
        let endpoint = "\(APIConfig.OpenWeatherMap.baseURL)/forecast?q=\(location)&appid=\(APIConfig.OpenWeatherMap.apiKey)"
                
        let response: ForecastResponse = try await networkService.fetch(from: endpoint)
        
        return processForecastResponse(response)
    }
    
    func fetchAirQuality(for location: String) async throws -> AirQuality {
        let coords = try await locationService.getCoordinates(for: location)
        let endpoint = "\(APIConfig.OpenWeatherMap.baseURL)/air_pollution?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(APIConfig.OpenWeatherMap.apiKey)"
        
        let response: AirPollutionResponse = try await networkService.fetch(from: endpoint)
        
        guard let domainModel = response.toDomainModel() else {
            throw WeatherError.invalidData
        }
        return domainModel
    }
    
    private func kelvinToCelsius(_ kelvin: Double) -> Int {
        return Int(round(kelvin - 273.15))
    }
    
    private func processForecastResponse(_ response: ForecastResponse) -> [DayForecast] {
        let grouped = Dictionary(grouping: response.list) { forecast in
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            return formatter.string(from: forecast.date)
        }
        
        return grouped.suffix(5).compactMap { (day, entries) in
            let highs = entries.map { $0.main.temp_max }
            let lows = entries.map { $0.main.temp_min }
            let icon = entries.first?.weather.first?.icon ?? ""
            let conditions = entries.compactMap { $0.weather.first?.main }
            
            return DayForecast(
                day: day,
                high: kelvinToCelsius(highs.max() ?? 0),
                low: kelvinToCelsius(lows.min() ?? 0),
                condition: conditions.first ?? "",
                icon: icon
            )
        }
    }
}

class WeatherComAPIClient: AlertsAPIClient {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchAlerts(for location: String) async throws -> [WeatherAlert] {
        let endpoint = "\(APIConfig.WeatherAPI.baseURL)/alerts.json?key=\(APIConfig.WeatherAPI.apiKey)&q=\(location)"
        
        print("alerts: \(endpoint)")
        
        let response: AlertsResponse = try await networkService.fetch(from: endpoint)
        
        return response.alerts.alert.map { alert in
            WeatherAlert(title: alert.headline, description: alert.desc, severity: alert.severity)
        }
    }
    
    func fetchAstronomy(for location: String, when date: String) async throws -> AstronomyInfo {
        let endpoint = "\(APIConfig.WeatherAPI.baseURL)/astronomy.json?key=\(APIConfig.WeatherAPI.apiKey)&q=\(location)&dt=\(date)"
                
        let response: AstronomyResponse = try await networkService.fetch(from: endpoint)
        
        return response.astronomy.astro.toDomainModel()
    }
}
