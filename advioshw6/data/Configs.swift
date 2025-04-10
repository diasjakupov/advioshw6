//
//  Configs.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//

import SwiftUI

struct APIConfig {
    struct OpenWeatherMap {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
        static let apiKey = "2a2c2fb0cac0f482c32ad316a70695ed"
    }
    
    struct WeatherAPI {
        static let baseURL = "https://api.weatherapi.com/v1"
        static let apiKey = "ee9c841d01574156b2e180802250904"
    }
}
