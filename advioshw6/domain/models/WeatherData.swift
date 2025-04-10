//
//  WeatherData.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct WeatherData: Identifiable {
    let id = UUID()
    var type: WeatherComponentType
    var state: LoadingState
    var data: Any?
    var errorMessage: String?
}

enum WeatherComponentType: String, CaseIterable {
    case currentConditions = "Current Conditions"
    case forecast = "5-Day Forecast"
    case astronomy = "Astronomy"
    case airQuality = "Air Quality"
    case alerts = "Weather Alerts"
}

enum LoadingState {
    case notLoaded
    case loading(progress: Float)
    case loaded
    case error
}
