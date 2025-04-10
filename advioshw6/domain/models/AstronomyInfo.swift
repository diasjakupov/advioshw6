//
//  Astronomy.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//

import SwiftUI

struct AstronomyInfo: Identifiable {
    let id = UUID()
    let sunrise: String
    let sunset: String
    let moonPhase: String
    let isSunUp: Bool
    let isMoonUp: Bool
}
