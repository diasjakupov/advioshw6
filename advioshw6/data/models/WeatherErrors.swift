//
//  WeatherErrors.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

enum WeatherError: Error {
    case invalidLocation
    case invalidURL
    case serverError(Int)
    case networkError(String)
    case decodingError(Error)
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidLocation:
            return "Could not find the specified location"
        case .invalidURL:
            return "Invalid URL format"
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .networkError(let message):
            return "Network error: \(message)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .invalidData:
            return "Invalid data received from server"
        }
    }
}
