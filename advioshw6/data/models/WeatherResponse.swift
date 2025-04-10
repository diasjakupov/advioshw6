//
//  WeatherResponse.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct OpenWeatherMapResponse: Decodable {
    let coord: Coord
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    let weather: [Weather]
    
    let base: String
    
    struct Main: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }
    let main: Main
    
    let visibility: Int
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }
    let wind: Wind
    
    let rain: [String: Double]?
    
    let clouds: [String: Int]
    let dt: Int
    
    struct Sys: Decodable {
        let type: Int?
        let id: Int?
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    let sys: Sys
    
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}
