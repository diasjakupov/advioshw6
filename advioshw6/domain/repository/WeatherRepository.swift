//
//  WeatherRepository.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

protocol WeatherRepository {
    func fetchCurrentConditions(for location: String, forceRefresh: Bool) async throws -> CurrentWeather
    func fetchForecast(for location: String) async throws -> [DayForecast]
    func fetchAirQuality(for location: String) async throws -> AirQuality
}
