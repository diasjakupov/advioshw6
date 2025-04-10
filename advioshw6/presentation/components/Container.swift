//
//  Container.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct WeatherComponentContainerView: View {
    let component: WeatherData
    let retry: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(component.type.rawValue)
                .font(.headline)
                .foregroundColor(.white)
            
            contentView
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch component.state {
        case .notLoaded:
            NotLoadedView()
            
        case .loading(let progress):
            LoadingView(progress: progress)
            
        case .loaded:
            loadedContentView
            
        case .error:
            ErrorView(errorMessage: component.errorMessage) {
                retry()
            }
        }
    }
    
    @ViewBuilder
    private var loadedContentView: some View {
        switch component.type {
        case .currentConditions:
            if let currentWeather = component.data as? CurrentWeather {
                CurrentConditionsView(weather: currentWeather)
            }
            
        case .forecast:
            if let forecast = component.data as? [DayForecast] {
                ForecastView(forecast: forecast)
            }
            
        case .astronomy:
            if let info = component.data as? AstronomyInfo{
                AstronomyView(info: info)
            }
            
        case .airQuality:
            if let airQuality = component.data as? AirQuality {
                AirQualityView(airQuality: airQuality)
            }
            
        case .alerts:
            if let alerts = component.data as? [WeatherAlert] {
                AlertsView(alerts: alerts)
            }
        }
    }
}
