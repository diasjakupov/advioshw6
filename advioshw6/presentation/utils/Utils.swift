//
//  Utils.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//


import SwiftUI

struct WeatherHelpers {    
    static func airQualityColor(for quality: String) -> Color {
        switch quality.lowercased() {
        case "good":
            return Color.green
        case "fair":
            return Color.yellow
        case "moderate":
            return Color.orange
        case "poor":
            return Color.red
        case "very poor":
            return Color.gray
        default:
            return Color.black
        }
    }
    
    static func alertColor(for severity: String) -> Color {
        switch severity.lowercased() {
        case "low":
            return Color.yellow
        case "moderate":
            return Color.orange
        case "high":
            return Color.red
        case "severe":
            return Color.purple
        default:
            return Color.orange
        }
    }
}
