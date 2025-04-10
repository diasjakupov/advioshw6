//
//  DayForecast.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct DayForecast: Identifiable {
    let id = UUID()
    let day: String
    let high: Int
    let low: Int
    let condition: String
    let icon: String
}
