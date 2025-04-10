//
//  WeatherViewModel.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//


import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherComponents: [WeatherData] = []
    @Published var isRefreshing = false
    @Published var selectedCity: String {
        didSet {
            if oldValue != selectedCity {
                loadAllData(forceRefresh: false)
            }
        }
    }
    
    private var coords: Coord? = nil
    
    private let weatherRepository: WeatherRepository
    private let alertsRepository: WeatherComRepository
    
    init(initialCity: String = "San Francisco") {
        let networkService = DefaultNetworkService()
        let locationService = CoreLocationService()
        let weatherAPIClient = OpenWeatherMapClient(networkService: networkService, locationService: locationService)
        let alertsAPIClient = WeatherComAPIClient(networkService: networkService)
        
        let repository = DefaultWeatherRepository(
            weatherAPIClient: weatherAPIClient, alertsAPIClient: alertsAPIClient
        )
        self.weatherRepository = repository
        self.alertsRepository = repository
        self.selectedCity = initialCity
        
        weatherComponents = WeatherComponentType.allCases.map { type in
            WeatherData(type: type, state: .notLoaded)
        }
    }
    
    func loadAllData(forceRefresh: Bool = false) {
        isRefreshing = true
        
        Task {
            await fetchAllComponentsData(forceRefresh: forceRefresh)
            isRefreshing = false
        }
    }
    
    private func fetchAllComponentsData(forceRefresh: Bool) async {
        await withTaskGroup(of: (WeatherComponentType, DataResult).self) { group in
            for componentType in WeatherComponentType.allCases {
                group.addTask {
                    await self.fetchComponentData(type: componentType, forceRefresh: forceRefresh)
                }
            }
            
            for await (type, result) in group {
                if let index = self.weatherComponents.firstIndex(where: { $0.type == type }) {
                    switch result {
                    case .success(let data):
                        self.weatherComponents[index].state = .loaded
                        self.weatherComponents[index].data = data
                    case .failure(let error):
                        self.weatherComponents[index].state = .error
                        self.weatherComponents[index].errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
    
    private func fetchComponentData(type: WeatherComponentType, forceRefresh: Bool) async -> (WeatherComponentType, DataResult) {
        if let index = weatherComponents.firstIndex(where: { $0.type == type }) {
            await MainActor.run {
                weatherComponents[index].state = .loading(progress: 0.0)
            }
            
            await simulateProgressUpdates(for: type, at: index)
            
            do {
                let data = try await fetchData(for: type, forceRefresh: forceRefresh)
                return (type, .success(data))
            } catch {
                return (type, .failure(error))
            }
        }
        return (type, .failure(NSError(domain: "WeatherViewModel", code: 404, userInfo: [NSLocalizedDescriptionKey: "Component not found"])))
    }
    
    private func simulateProgressUpdates(for type: WeatherComponentType, at index: Int) async {
        let delay = 0.1
        
        for progress in stride(from: 0.1, through: 0.9, by: 0.1) {
            try? await Task.sleep(for: .seconds(delay))
            
            await MainActor.run {
                if index < weatherComponents.count {
                    weatherComponents[index].state = .loading(progress: Float(progress))
                }
            }
        }
    }
    
    private func fetchData(for type: WeatherComponentType, forceRefresh: Bool) async throws -> Any {
        switch type {
        case .currentConditions:
            return try await weatherRepository.fetchCurrentConditions(for: selectedCity, forceRefresh: forceRefresh)
        case .forecast:
            return try await weatherRepository.fetchForecast(for: selectedCity)
        case .astronomy:
            return try await alertsRepository.fetchAstronomyInfo(for: selectedCity)
        case .airQuality:
            return try await weatherRepository.fetchAirQuality(for: selectedCity)
        case .alerts:
            return try await alertsRepository.fetchWeatherAlerts(for: selectedCity)
        }
    }
    
    func refreshComponent(_ type: WeatherComponentType) {
        Task {
            let result = await fetchComponentData(type: type, forceRefresh: true)
            if let index = weatherComponents.firstIndex(where: { $0.type == result.0 }) {
                switch result.1 {
                case .success(let data):
                    weatherComponents[index].state = .loaded
                    weatherComponents[index].data = data
                case .failure(let error):
                    weatherComponents[index].state = .error
                    weatherComponents[index].errorMessage = error.localizedDescription
                }
            }
        }
    }
}

private enum DataResult {
    case success(Any)
    case failure(Error)
}
