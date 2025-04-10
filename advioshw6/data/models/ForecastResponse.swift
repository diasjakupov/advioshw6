//
//  ForecastResponse.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct ForecastResponse: Decodable {
    let list: [ForecastEntry]
}

struct ForecastEntry: Decodable {
    let main: TemperatureData
    let weather: [WeatherCondition]
    let dtTxt: String
    
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: dtTxt) ?? Date()
    }

    enum CodingKeys: String, CodingKey {
        case main, weather
        case dtTxt = "dt_txt"
    }
}


struct TemperatureData: Decodable {
    let temp_min: Double
    let temp_max: Double
}

struct WeatherCondition: Decodable {
    let main: String
    let icon: String
}
