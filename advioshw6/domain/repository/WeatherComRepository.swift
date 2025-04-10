//
//  AlertsRepository.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

protocol WeatherComRepository{
    func fetchWeatherAlerts(for location: String) async throws -> [WeatherAlert]
    func fetchAstronomyInfo(for location: String) async throws -> AstronomyInfo
}
